{
	"Version": "2008-10-17",
	"Statement":[
		{
			"Sid": "AllowSSLRequestsOnly",
			"Action": "s3:*",
			"Effect": "Deny",
			"Resource": [
				"${resource}",
				"${resource}/*"
			],
			"Condition": {
				"Bool": {
					"aws:SecureTransport": "false"
				}
			},
			"Principal": "*"
		}
	]
}