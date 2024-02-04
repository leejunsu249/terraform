import json
import boto3
import os

def eks_ue2_stop():
    region_name = 'us-east-2'

    # EKS 클라이언트 생성
    eks_client = boto3.client('eks', region_name=region_name)

    # EKS 클러스터 이름
    cluster_name = 'eks-ue2-stg-naemo'

    # EKS 클러스터의 모든 노드 그룹 가져오기
    response = eks_client.list_nodegroups(clusterName=cluster_name)
    new_desired_capacity = 0
    new_min_size = 0

    # 노드 그룹 이름을 리스트로 출력
    nodegroups = response['nodegroups']
    print("Node Groups in the EKS cluster:")
    for nodegroup in nodegroups:
        if nodegroup.startswith('manage'):
            print(nodegroup+"가 제외 되었습니다")
            pass
        else:
            try:
                result = eks_client.update_nodegroup_config(
                clusterName=cluster_name,
                nodegroupName=nodegroup,
                scalingConfig={
                'desiredSize': new_desired_capacity,
                'minSize': new_min_size
                })
                print(f"Node group {nodegroup} updated to have {new_desired_capacity} desired nodes.")
            except Exception as e:
                print(f"An error occurred: {str(e)}")

def eks_an2_stop():
    region_name = 'ap-northeast-2'

    # EKS 클라이언트 생성
    eks_client = boto3.client('eks', region_name=region_name)

    # EKS 클러스터 이름
    cluster_name = 'eks-an2-stg-naemo-wallet'

    # EKS 클러스터의 모든 노드 그룹 가져오기
    response = eks_client.list_nodegroups(clusterName=cluster_name)
    new_desired_capacity = 0
    new_min_size = 0

    # 노드 그룹 이름을 리스트로 출력
    nodegroups = response['nodegroups']
    print("Node Groups in the EKS cluster:")
    for nodegroup in nodegroups:
        if nodegroup.startswith('wallet_manage'):
            print(nodegroup+"가 제외 되었습니다")
            pass
        else:
            try:
                result = eks_client.update_nodegroup_config(
                clusterName=cluster_name,
                nodegroupName=nodegroup,
                scalingConfig={
                'desiredSize': new_desired_capacity,
                'minSize': new_min_size
                })
                print(f"Node group {nodegroup} updated to have {new_desired_capacity} desired nodes.")
            except Exception as e:
                print(f"An error occurred: {str(e)}")


if __name__ == '__main__':
    eks_ue2_stop()
    eks_an2_stop()
