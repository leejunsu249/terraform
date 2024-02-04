#!/bin/bash

#Create aws dir for root user
mkdir ~/.aws

#Create config file with minimum required content for aws cli to work
cat << EOF > ~/.aws/config
[default]
region = `curl -s 169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//'`
EOF

#Set Hostname
sudo hostnamectl set-hostname `aws ec2 describe-tags --filters "Name=resource-id,Values=\`curl -s http://169.254.169.254/latest/meta-data/instance-id\`" --output=text | grep Name | awk '{print $5}'`

echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg

groupadd -g 9000 search
useradd -g search -u 9000 -m -d /home/search -c "search engine service account" search
mkdir /home/search/.ssh
chmod 700 /home/search/.ssh
cat <<EOF > /home/search/.ssh/authorized_keys
${keypair_search}
EOF
chmod 600 /home/search/.ssh/authorized_keys
chown -R search:search /home/search/.ssh