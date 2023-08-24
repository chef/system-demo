#!/bin/bash
echo "waiting for node API to be online"
curl --retry 18 --retry-delay 10 -s -o /dev/null "http://192.168.0.10:9676/v1/nodes/"              
function find() {
    curl -s http://192.168.0.10:9676/v1/nodes/ | jq -r --arg IP "ip-$1" '.data[] | select(.attributes[].value | contains($IP)) | .id'
}

echo "update .bashrc"
echo "export NODE1=$(find "192-168-10-10")" >> /home/ec2-user/.bashrc
echo "export NODE2=$(find "192-168-10-20")" >> /home/ec2-user/.bashrc
echo "export NODE3=$(find "192-168-10-30")" >> /home/ec2-user/.bashrc
echo "export NODE4=$(find "192-168-20-10")" >> /home/ec2-user/.bashrc
echo "export NODE5=$(find "192-168-20-20")" >> /home/ec2-user/.bashrc
echo "export NODE6=$(find "192-168-20-30")" >> /home/ec2-user/.bashrc
echo "export NODE7=$(find "192-168-30-10")" >> /home/ec2-user/.bashrc
echo "export NODE8=$(find "192-168-30-20")" >> /home/ec2-user/.bashrc
echo "export NODE9=$(find "192-168-30-30")" >> /home/ec2-user/.bashrc