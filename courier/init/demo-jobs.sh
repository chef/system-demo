#!/bin/bash -xe   
echo "waiting for node API to be online"
curl --retry 18 --retry-delay 10 -s -o /dev/null "http://$1:9676/v1/nodes/"              
function find() {
    curl -s http://$1:9676/v1/nodes/ | jq -r --arg IP "ip-$2" '.data[] | select(.attributes[].value | contains($IP)) | .id'
}

NODE1=$(find $1 "192-168-10-10")
NODE2=$(find $1 "192-168-10-20")
NODE3=$(find $1 "192-168-10-30")
NODE4=$(find $1 "192-168-20-10")
NODE5=$(find $1 "192-168-20-20")
NODE6=$(find $1 "192-168-20-30")
NODE7=$(find $1 "192-168-30-10")
NODE8=$(find $1 "192-168-30-20")
NODE9=$(find $1 "192-168-30-30")

FILES="/home/ec2-user/content/jobs/*.json"
for f in $FILES
do
# FAILSAFE #
# Check if "$f" FILE exists and is a regular file and then only copy it #
  if [ -f "$f" ]
  then
    sed -i "s/--NODE1--/$NODE1/g" $f
    sed -i "s/--NODE2--/$NODE2/g" $f
    sed -i "s/--NODE3--/$NODE3/g" $f
    sed -i "s/--NODE4--/$NODE4/g" $f
    sed -i "s/--NODE5--/$NODE5/g" $f
    sed -i "s/--NODE6--/$NODE6/g" $f
    sed -i "s/--NODE7--/$NODE7/g" $f
    sed -i "s/--NODE8--/$NODE8/g" $f
    sed -i "s/--NODE9--/$NODE9/g" $f
  fi
done

shopt -s globstar
FILES="/home/ec2-user/demos/**/*.json"
for i in **/*.json; do # Whitespace-safe and recursive
  if [ -f "$f" ]
  then
    sed -i "s/--NODE1--/$NODE1/g" $f
    sed -i "s/--NODE2--/$NODE2/g" $f
    sed -i "s/--NODE3--/$NODE3/g" $f
    sed -i "s/--NODE4--/$NODE4/g" $f
    sed -i "s/--NODE5--/$NODE5/g" $f
    sed -i "s/--NODE6--/$NODE6/g" $f
    sed -i "s/--NODE7--/$NODE7/g" $f
    sed -i "s/--NODE8--/$NODE8/g" $f
    sed -i "s/--NODE9--/$NODE9/g" $f
  fi
done