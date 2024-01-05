#!/bin/bash 
set -x
KEY=$4                  #"apiuser"
SECRET=$3               #"b15606a050a60b5f"
SERVER=$1               #"http://192.168.1.10"
NODE_MANAGER_PORT=$2    #"9676"
PUBLIC_SERVER=$5    #"https://my.demo.chef.co"

# --------------
# Runner
sed -i "s|--API-KEY--|${KEY}|g" courier-runner-default-settings.json 
sed -i "s|--API-SECRET--|${SECRET}|g" courier-runner-default-settings.json 
sed -i "s|--SERVER--|${PUBLIC_SERVER}|g" courier-runner-default-settings.json 

TEMPLATE=$(cat courier-runner.tmpl | base64 -w 0)
sed -i "s|--TEMPLATE--|${TEMPLATE}|g" courier-runner.json

curl -X POST -H "Content-Type: application/json" -d @"courier-runner.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/skills/
curl -X PUT -H "Content-Type: application/json" -d @"courier-runner-default-settings.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/default-settings/skill/courier-runner

curl -X POST -H "Content-Type: application/json" -d @"courier-runner-linux-settings.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/settings/
curl -X POST -H "Content-Type: application/json" -d @"courier-runner-windows-settings.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/settings/

# --------------
# Gohai
sed -i "s|--API-KEY--|${KEY}|g" chef-gohai-default-settings.json 
sed -i "s|--API-SECRET--|${SECRET}|g" chef-gohai-default-settings.json 
sed -i "s|--SERVER--|${PUBLIC_SERVER}|g" chef-gohai-default-settings.json 

TEMPLATE=$(cat chef-gohai.tmpl | base64 -w 0)
sed -i "s|--TEMPLATE--|${TEMPLATE}|g" courier-runner.json

curl -X POST -H "Content-Type: application/json" -d @"chef-gohai.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/skills/
curl -X PUT -H "Content-Type: application/json" -d @"chef-gohai.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/default-settings/skill/chef-gohai

# --------------
# Shell
curl -X POST -H "Content-Type: application/json" -d @"courier-shell-interpreter.json" ${SERVER}:${NODE_MANAGER_PORT}/v1/skills/
