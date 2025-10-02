#!/bin/bash
# set -e

echo "=== Docker Swarm initializing ==="

if docker node ls &>/dev/null; then
    echo "Swarm already initialized"
else
    echo "Initializing swarm"
    docker swarm init --advertise-addr 192.168.56.2 --listen-addr 192.168.56.2:2377
fi

# echo "Checking port 2377..."
# sudo ss -tlnp | grep 2377 || echo "WARNING: Port 2377 not found"

docker swarm join-token -q worker > /vagrant/worker_token
echo "✅ Swarm initialized and token saved"
