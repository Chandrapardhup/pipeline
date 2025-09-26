ssh -o StrictHostKeyChecking=no -i ec2.pem ubuntu@65.1.64.5 "
cat << 'EOF' > ~/deploy.sh
#!/bin/bash
cd /home/ubuntu/pipeline || git clone https://github.com/Chandrapardhup/pipeline.git && cd pipeline
git pull
sudo docker build -t pipeline-app .
sudo docker stop pipeline-app || true && sudo docker rm pipeline-app || true
sudo docker run -d -p 22:22 --name pipeline-app pipeline-app
echo '${{ secrets.DOCKER_PASSWORD }}' | sudo docker login -u '${{ secrets.DOCKER_USERNAME }}' --password-stdin
sudo docker tag pipeline-app:latest ${{ secrets.DOCKER_USERNAME }}/pipeline-app:latest
sudo docker push ${{ secrets.DOCKER_USERNAME }}/pipeline-app:latest
EOF
chmod +x ~/deploy.sh
bash ~/deploy.sh
"

