#! /bin/bash

docker load -i projeto-deploy.tar

mv docker-compose-prod.yaml docker-compose.yaml

container_ids=$(docker ps -q)

if [ -z "$container_ids" ]; then
  echo "Não há containers em execução"
else
  for container_id in $container_ids; do
    echo "Parando container: $container_id"
    docker stop $container_id
  done
  echo "Todos os containers foram parados"
fi

docker compose up -d
