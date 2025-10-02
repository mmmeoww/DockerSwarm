#!/bin/bash
# set -e

MANAGER_IP="192.168.56.2"

echo "=== Joining Swarm ==="

echo "Waiting for manager node"
until ping -c1 $MANAGER_IP &>/dev/null; do
    sleep 2
    echo "Still waiting for manager..."
done

echo "Waiting for Docker Swarm port"
until nc -z $MANAGER_IP 2377 &>/dev/null; do
    sleep 2
    echo "Still waiting for port 2377"
done

echo "Waiting for swarm token..."
until [ -f /vagrant/worker_token ]; do
    sleep 2
done

SWARM_JOIN_TOKEN=$(cat /vagrant/worker_token)
docker swarm join --token "$SWARM_JOIN_TOKEN" "$MANAGER_IP":2377

echo "✅ Successfully joined swarm"