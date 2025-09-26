#!/bin/bash

# Go to repo folder or clone if missing
cd /home/ubuntu/pipeline || git clone https://github.com/Chandrapardhup/pipeline.git && cd pipeline
git pull

# Build Docker image
sudo docker build -t pipeline-app .

# Stop & remove old container
sudo docker stop pipeline-app || true
sudo docker rm pipeline-app || true

# Run container (port 80 in container → 8080 on EC2)
sudo docker run -d -p 8080:80 --name pipeline-app pipeline-app

# Docker login & push
echo "$DOCKER_PASSWORD" | sudo docker login -u "$DOCKER_USERNAME" --password-stdin
sudo docker tag pipeline-app:latest $DOCKER_USERNAME/pipeline-app:latest
sudo docker push $DOCKER_USERNAME/pipeline-app:latest
