#!/bin/bash 
set -x
KEY=$4                  #"apiuser"
SECRET=$3               #"b15606a050a60b5f"
SERVER=$1               #"http://192.168.1.10"
NODE_MANAGER_PORT=$2    #"9676"

sed -i "s|--API-KEY--|${KEY}|g" courier-runner-default-settings.json 
sed -i "s|--API-SECRET--|${SECRET}|g" courier-runner-default-settings.json 

TEMPLATE=$(cat courier-runner.tmpl | base64 -w 0)
echo $TEMPLATE >> b64
sed -i "s|--TEMPLATE--|${TEMPLATE}|g" courier-runner.json

curl -X POST -H "Content-Type: application/json" -d @"courier-runner.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/skills/
curl -X POST -H "Content-Type: application/json" -d @"courier-shell-interpreter.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/skills/

curl -X PUT -H "Content-Type: application/json" -d @"courier-runner-default-settings.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/default-settings/skill/courier-runner

curl -X POST -H "Content-Type: application/json" -d @"courier-runner-linux-settings.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/settings/
curl -X POST -H "Content-Type: application/json" -d @"courier-runner-windows-settings.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/settings/
