#!/bin/bash
INSTANCEID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
AWSREGION=`curl -s 169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//'`

#Create aws dir for root user
mkdir ~/.aws

#Create config file with minimum required content for aws cli to work
cat << EOF > ~/.aws/config
[default]
region = ${AWSREGION}
EOF

#Get Name tag value
INSTANCENAME=`aws ec2 describe-tags --filters "Name=resource-id,Values=${INSTANCEID}" --output=text | grep Name | awk '{print $5}'`

#Set Hostname
sudo hostnamectl set-hostname ${INSTANCENAME}

#Make sure we got a name, fail if we dont.
if [ -z "${INSTANCENAME}" ]
        then
        echo "I have no name!"
        exit 1
fi

echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
