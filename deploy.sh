#!/bin/sh

echo "Pre-Build Steps:"
echo "authenticating with AWS ECR..."

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 162041392922.dkr.ecr.us-east-1.amazonaws.com

echo "Build Steps:"
echo "building image..."

docker build -t 162041392922.dkr.ecr.us-east-1.amazonaws.com/capstoneproj:latest .

echo "Post-Build Steps:"
echo "pushing image to AWS ECR..."

docker push 162041392922.dkr.ecr.us-east-1.amazonaws.com/capstoneproj:latest

echo "updating AWS ECS service..."
aws ecs update-service --cluster capstoneproj-cluster --service caostoneproj-sv --force-new-deployment

echo "Done!"