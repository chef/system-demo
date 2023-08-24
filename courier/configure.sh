#!/bin/bash -xe   
if [ "$EUID" -ne 0 ]
  then echo "script must run as root"
  exit
fi

echo "creating /opt/demo"
mkdir -p /opt/demo
cp -r cmd/* /opt/demo
chown -R ec2-user:ec2-user /opt/demo
chmod a+x /opt/demo/*

echo "bin linking demo"
ln -s /opt/demo/chef /usr/bin/
ln -s /opt/demo/node /usr/bin/
ln -s /opt/demo/courier /usr/bin/

echo "copy instructions"
cp instructions.txt /home/ec2-user/
echo "copy commands"
cp commands.txt /home/ec2-user/
echo "copy content"
cp -R content /home/ec2-user/content
echo "copy notes"
cp -R notes/ /home/ec2-user/notes
echo "copy demos"
cp -R demos/ /home/ec2-user/demos

echo "fix owners"
chmod -R a+r /home/ec2-user/content
chmod -R a+r /home/ec2-user/notes
chown -R ec2-user:ec2-user /home/ec2-user/content
chown -R ec2-user:ec2-user /home/ec2-user/notes
chown -R ec2-user:ec2-user /home/ec2-user/instructions.txt
chown -R ec2-user:ec2-user /home/ec2-user/commands.txt

echo "fix file permisions"
chmod a+r /home/ec2-user/instructions.txt
chmod a+r /home/ec2-user/commands.txt

echo "init nodes"
/home/ec2-user/system-demo/courier/init/nodes.sh $1

echo "init skills"
/home/ec2-user/system-demo/courier/init/skills.sh $1
