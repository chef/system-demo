#!/bin/bash 
echo "waiting for node API to be online"
curl --retry 18 --retry-delay 10 -s -o /dev/null "http://$1:9676/v1/nodes/"              
function register() {
    echo "registering skill $2"
    curl -s -X POST -H "Content-Type: application/json" -d @"$2" http://$1:9676/v1/skills/
}

FILES="/home/ec2-user/system-demo/courier/default/skills/*.json"
for f in $FILES
do
# FAILSAFE #
# Check if "$f" FILE exists and is a regular file and then only copy it #
  if [ -f "$f" ]
  then
    register $1 $f
  fi
done
