#!/bin/bash

echo "downloading portainer.yml"
curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer.yml

echo "deploying portainer"
docker stack deploy -c portainer.yml portainer