# Run docker compose and log output with timestamp
docker compose up -f "~/finance/stock-analyser-deploy/prod/docker-compose.yml" 2>&1 | ts '[%Y-%m-%d %H:%M:%S]' >> "logs/logs_$(date '+%Y-%m-%d_%H-%M').log"

# Get the instance ID dynamically
INSTANCE_ID=$(ec2-metadata -i | awk '{print $2}')

aws ec2 stop-instances --instance-ids $INSTANCE_ID