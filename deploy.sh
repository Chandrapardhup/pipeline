#!/bin/bash
cd /home/ubuntu/pipeline || git clone https://github.com/Chandrapardhup/pipeline.git && cd pipeline
git pull
sudo docker build -t pipeline-app .
sudo docker stop pipeline-app || true && sudo docker rm pipeline-app || true
sudo docker run -d -p 8080:80 --name pipeline-app pipeline-app
echo "$DOCKER_PASSWORD" | sudo docker login -u "$DOCKER_USERNAME" --password-stdin
sudo docker tag pipeline-app:latest $DOCKER_USERNAME/pipeline-app:latest
sudo docker push $DOCKER_USERNAME/pipeline-app:latest
