#!/bin/bash -xe   
if [ "$EUID" -ne 0 ]
  then echo "script must run as root"
  exit
fi

echo "copy instructions"
cp instructions.txt /home/ec2-user/
echo "copy instructions markdown"
cp instructions.md /home/ec2-user/

echo "copy demo"
cp -R demo/ /home/ec2-user/demo

echo "fix owners"
chown -R ec2-user:ec2-user /home/ec2-user/instructions.txt
chown -R ec2-user:ec2-user /home/ec2-user/instructions.md

echo "fix file permisions"
chmod a+r /home/ec2-user/instructions.txt
chmod a+r /home/ec2-user/instructions.md
