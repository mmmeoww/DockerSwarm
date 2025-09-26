#!/bin/bash
set -e

echo "=== Ensuring Docker Swarm is initialized ==="

# Проверяем текущий статус Swarm
if docker node ls &>/dev/null; then
    echo "Swarm already initialized"
else
    echo "Initializing new swarm..."
    docker swarm init --advertise-addr 192.168.56.2
fi

# Дополнительная проверка
echo "Verifying swarm status..."
docker node ls

echo "Checking port 2377..."
sudo ss -tlnp | grep 2377 || echo "WARNING: Port 2377 not found"

# Сохраняем токен
docker swarm join-token -q worker > /vagrant/worker_token
echo "✅ Swarm initialized and token saved"