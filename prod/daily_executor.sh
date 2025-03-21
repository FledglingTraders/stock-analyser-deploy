#!/bin/bash

git pull

aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 108782078484.dkr.ecr.eu-north-1.amazonaws.com

# Ensure logs directory exists
mkdir -p logs

# Run docker compose and log output with timestamp don't log in terminal
# docker compose -f ~/finance/stock-analyser-deploy/develop/docker-compose.yml up 2>&1 | ts '[%Y-%m-%d %H:%M:%S]' >> "logs/logs_$(date '+%Y-%m-%d_%H-%M').log"

# Run docker compose, log output to both terminal and file
docker compose -f ~/finance/stock-analyser-deploy/prod/docker-compose.yml up 2>&1 | ts '[%Y-%m-%d %H:%M:%S]' | tee -a "logs/logs_$(date '+%Y-%m-%d_%H-%M').log"

# Get the instance ID dynamically
INSTANCE_ID=$(ec2-metadata -i | awk '{print $2}')

# aws ec2 stop-instances --instance-ids
