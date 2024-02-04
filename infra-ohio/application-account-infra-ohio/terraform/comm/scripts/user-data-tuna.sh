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

groupadd -g 9000 tuna
useradd -g tuna -u 9000 -m -d /home/tuna -c "TunA service account" tuna
mkdir /home/tuna/.ssh
chmod 700 /home/tuna/.ssh
cat <<EOF > /home/tuna/.ssh/authorized_keys
${keypair_tuna}
EOF
chmod 600 /home/tuna/.ssh/authorized_keys
chown -R tuna:tuna /home/tuna/.ssh