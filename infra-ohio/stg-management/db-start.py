import json
import boto3

regions = ['us-east-2','ap-northeast-2']
for region in regions:
    rds_session = boto3.client('rds',region_name=region)


    response = rds_session.describe_db_clusters()

    for db_instance in response.get('DBClusters'):
        status = db_instance.get('Status')
        if 'available' ==  status:
           print("시작 가능한 RDS가 없습니다.")
        else:
            try:
                db_cluster_identifier = db_instance.get('DBClusterIdentifier')
                response = rds_session.start_db_cluster(DBClusterIdentifier=db_cluster_identifier)
                print(f"Start RDS instance {db_cluster_identifier}...")
            except Exception as e:
                print(f"An error occurred: {str(e)}")


