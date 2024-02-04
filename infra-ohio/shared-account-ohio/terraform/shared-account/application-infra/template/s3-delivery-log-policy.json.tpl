{
    "Statement":[
        {
            "Sid": "AWSLogDeliveryWrite",
            "Effect": "Allow",
            "Principal": {"Service": "delivery.logs.amazonaws.com" },
            "Action": "s3:PutObject",
            "Resource": [
				"${resource}/dev/*",
				"${resource}/stg/*",
				"${resource}/prd/*",
				"${resource}/net/*",
				"${resource}/shd/*"
			],
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control",
                    "aws:SourceAccount": ["351894368755", "385866877617", "087942668956", "908317417455", "676826599814"]
                },
                "ArnLike": {
                    "aws:SourceArn": [
						"arn:aws:logs:us-east-2:351894368755:*",
						"arn:aws:logs:us-east-2:385866877617:*",
						"arn:aws:logs:us-east-2:087942668956:*",
						"arn:aws:logs:us-east-2:908317417455:*",
                        "arn:aws:logs:us-east-2:676826599814:*",
						"arn:aws:logs:ap-northeast-2:351894368755:*",
						"arn:aws:logs:ap-northeast-2:385866877617:*",
						"arn:aws:logs:ap-northeast-2:087942668956:*",
						"arn:aws:logs:ap-northeast-2:908317417455:*",
                        "arn:aws:logs:ap-northeast-2:676826599814:*"
					]
                }
            }
        },
        {
            "Sid": "AWSLogDeliveryCheck",
            "Effect": "Allow",
            "Principal": {"Service": "delivery.logs.amazonaws.com"},
            "Action": ["s3:GetBucketAcl"],
            "Resource": "${resource}",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": ["351894368755", "385866877617", "087942668956", "908317417455", "676826599814"]
                },
                "ArnLike": {
                    "aws:SourceArn": [
						"arn:aws:logs:us-east-2:351894368755:*",
						"arn:aws:logs:us-east-2:385866877617:*",
						"arn:aws:logs:us-east-2:087942668956:*",
						"arn:aws:logs:us-east-2:908317417455:*",
                        "arn:aws:logs:us-east-2:676826599814:*",
						"arn:aws:logs:ap-northeast-2:351894368755:*",
						"arn:aws:logs:ap-northeast-2:385866877617:*",
						"arn:aws:logs:ap-northeast-2:087942668956:*",
						"arn:aws:logs:ap-northeast-2:908317417455:*",
                        "arn:aws:logs:ap-northeast-2:676826599814:*"
					]
                }
            }
        }
    ]
}