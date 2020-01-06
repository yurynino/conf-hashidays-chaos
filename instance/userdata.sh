#!/bin/bash
mkdir /var/lib/gremlin
cd /var/lib/gremlin
wget https://gremlin-private.s3-us-west-2.amazonaws.com/adl-client.priv_key.pem
wget https://gremlin-private.s3-us-west-2.amazonaws.com/adl-client.priv_key.pem
cd
yum update -y
curl https://rpm.gremlin.com/gremlin.repo -o /etc/yum.repos.d/gremlin.repo
yum install -y gremlin gremlind
export INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
export GREMLIN_TEAM_ID=CHANGEME
GREMLIN_TEAM_ID="CHANGEME"GREMLIN_TEAM_CERTIFICATE_OR_FILE="file:///var/lib/gremlin/adl-client.pub_cert.pem"GREMLIN_TEAM_PRIVATE_KEY_OR_FILE="file:///var/lib/gremlin/adl-client.priv_key.pem"
gremlin init -s autoconnect --tag instance_id=$INSTANCE_ID --tag owner=CHANGEME
