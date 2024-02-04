import json
import boto3

regions = ['us-east-2','ap-northeast-2']
change_tag_ec2 = []
ec2_ids = []
for region in regions:
    # ec2_session = boto3.client('ec2',region_name=region)
    # instances = ec2_session.describe_instances(
    #         Filters = [{'Name': 'instance-state-name', 'Values':['stopped']}]
    #         ).get('Reservations')

    # for instance in instances:
    #     for ec2 in instance.get('Instances'):
    #         if ec2.get('Tags'):
    #             for tag in ec2.get('Tags'):
    #                 ## test로 시작되는 인스턴스 시작
    #                 if tag.get('Key') == 'Name' and tag.get('Value').startswith('test'):
    #                     print(tag.get('Value'))
    #                     change_tag_ec2.append(tag.get('Value'))
    #                 else:
    #                     pass
    # for change_tag in change_tag_ec2:
    #     instances2 = ec2_session.describe_instances(
    #     Filters = [{'Name': 'tag:Name', 'Values':[change_tag]}]
    #         ).get('Reservations')
        
    #     print("인스턴스를 시작 합니다")
    #     for instance2 in instances2:
    #         for ec2 in instance2.get('Instances'):
    #             ec2_ids.append(ec2.get('InstanceId'))
    #             try:
    #                 ec2_session.start_instances(InstanceIds=ec2_ids)
    #                 print(f"ec2 '{ec2_ids}'가 성공적으로 시작 되었습니다.")
    #             except ec2_session.exceptions.ResourceNotFoundException:
    #                 print(f"ec2 '{ec2_ids}'를 찾을 수 없습니다.")
    #             except Exception as e:
    #                 print(f"ec2 '{ec2_ids}'의 시작 중 오류가 발생했습니다: {str(e)}")
    
    print("batch 활성화 시작")
    service_name = 'events' 
    batch_client = boto3.client(service_name, region_name=region)
    ## prefix 가 batch인것만 활성화
    response = batch_client.list_rules(NamePrefix='batch', Limit=100)
    for rule in response['Rules']:
        try:
            batch_client.enable_rule(Name=rule.get('Name'))
            print(f"스케쥴러 규칙 '{rule.get('Name')}'가 성공적으로 활성화되었습니다.")
        except batch_client.exceptions.ResourceNotFoundException:
            print(f"스케쥴러 규칙 '{rule.get('Name')}'을 찾을 수 없습니다.")
        except Exception as e:
            print(f"스케쥴러 규칙 '{rule.get('Name')}'의 활성화 중 오류가 발생했습니다: {str(e)}")


