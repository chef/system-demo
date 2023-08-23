#cat file2 >> file1
if [ "$EUID" -ne 0 ]
  then echo "script must run as root"
  exit
fi

mkdir -p /opt/demo
cp -r cmd/* /opt/demo
chown -R ec2-user:ec2-user /opt/demo
chmod a+x /opt/demo/*
ln -s /opt/demo/chef /usr/bin/
ln -s /opt/demo/node /usr/bin/
ln -s /opt/demo/courier /usr/bin/

cp instructions.txt ../../
cp commands.txt ../../
cp -R content ../../content
cp -R notes/ ../../notes
cp -R demos/ ../../demos

chmod -R a+r /home/ec2-user/content
chmod -R a+r /home/ec2-user/notes
chmod a+r /home/ec2-user/instructions.txt
chmod a+r /home/ec2-user/commands.txt
chown -R ec2-user:ec2-user /home/ec2-user/content
chown -R ec2-user:ec2-user /home/ec2-user/notes
chown -R ec2-user:ec2-user /home/ec2-user/instructions.txt
chown -R ec2-user:ec2-user /home/ec2-user/commands.txt
./init/nodes.sh
