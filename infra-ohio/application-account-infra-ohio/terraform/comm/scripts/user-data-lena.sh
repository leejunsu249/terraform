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

groupadd -g 9000 lena
useradd -g lena -u 9000 -m -d /home/lena -c "lena manager service account" lena
mkdir /home/lena/.ssh
chmod 700 /home/lena/.ssh
cat <<EOF > /home/tuna/.ssh/authorized_keys
${keypair_lena}
EOFchmod 600 /home/lena/.ssh/authorized_keys
chown -R lena:lena /home/lena/.ssh
