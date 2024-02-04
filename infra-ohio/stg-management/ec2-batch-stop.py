import json
import boto3

regions = ['us-east-2','ap-northeast-2']

for region in regions:
    ec2_session = boto3.client('ec2',region_name=region) 
    # stop 하지 말아야할 인스턴스 필터링 
    noshut_instances = ec2_session.describe_instances(
        Filters = [{'Name': 'instance-state-name', 'Values':['running']},
        {'Name':'tag:Name', 'Values':['management_bottlerocket_node_v2']}]
        ).get('Reservations')


#stop 인스턴스 필터링 
    instances = ec2_session.describe_instances(
        Filters = [{'Name': 'instance-state-name', 'Values':['running']}]
        ).get('Reservations')

# no stop ec2 id 추출 
    noshut_ec2_ids = []
    stop_ec2_ids = []
    for instance in noshut_instances:
        for ec2 in instance['Instances']:
            noshut_ec2_ids.append(ec2['InstanceId'])


# stop ec2 id 추출 
    for instance in instances:
        for ec2 in instance['Instances']:
            stop_ec2_ids.append(ec2['InstanceId'])
        # no stop ec2 id list 에서 제거 
            for noshut_ec2 in noshut_ec2_ids:
                if noshut_ec2 in stop_ec2_ids:
                    stop_ec2_ids.remove(noshut_ec2)
                else:
                    pass

#     # 필터링 제외 인스턴스 스탑 
        if len(stop_ec2_ids) > 0:
            try: 
                ec2_session.stop_instances(InstanceIds=stop_ec2_ids)
                print(f"ec2 '{stop_ec2_ids}'가 성공적으로 정지 되었습니다.")
            except ec2_session.exceptions.ResourceNotFoundException:
                print(f"ec2 '{stop_ec2_ids}'을 찾을 수 없습니다.")
            except Exception as e:
                print(f"ec2 '{stop_ec2_ids}'의 정지 중 오류가 발생했습니다: {str(e)}")

    print("batch 비활성화 시작")
    service_name = 'events' 
    batch_client = boto3.client(service_name, region_name=region)
    ## prefix 가 batch로 시작되는 이벤트 브릿지 규칙 비활성화
    response = batch_client.list_rules(NamePrefix='batch', Limit=100)
    for rule in response['Rules']:
        try:
            batch_client.disable_rule(Name=rule.get('Name'))
            print(f"스케쥴러 규칙 '{rule.get('Name')}'가 성공적으로 비활성화되었습니다.")
        except batch_client.exceptions.ResourceNotFoundException:
            print(f"스케쥴러 규칙 '{rule.get('Name')}'을 찾을 수 없습니다.")
        except Exception as e:
            print(f"스케쥴러 규칙 '{rule.get('Name')}'의 비활성화 중 오류가 발생했습니다: {str(e)}")
