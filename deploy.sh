#!/bin/bash

# WebAuto Test Website Deployment Script
# This script is called by the WebAuto system when a webhook is received
# Repository: https://github.com/zfusx/test-website
# Webhook: https://wh1.zfus.net/webhook?key=test-site-key

set -e

echo "🚀 Starting deployment of test website..."

# Configuration
CONTAINER_NAME="webauto-test-site"
IMAGE_NAME="webauto-test-website"
PORT="3001"
REPO_DIR="/opt/websites/test-website"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    error "Docker is not running!"
    exit 1
fi

# Ensure we're in the correct directory
cd "$REPO_DIR" || {
    error "Repository directory not found: $REPO_DIR"
    exit 1
}

log "Pulling latest changes from repository..."
git pull origin main || {
    error "Git pull failed!"
    exit 1
}

log "Stopping existing container if running..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

log "Building new Docker image..."
docker build -t $IMAGE_NAME .

log "Starting new container..."
docker run -d \
    --name $CONTAINER_NAME \
    --restart unless-stopped \
    -p $PORT:80 \
    $IMAGE_NAME

# Wait for container to be ready
log "Waiting for container to be ready..."
sleep 5

# Health check
if curl -f http://localhost:$PORT/health > /dev/null 2>&1; then
    log "✅ Deployment successful! Website is running on port $PORT"
    log "🌐 Access at: http://localhost:$PORT"
else
    error "❌ Health check failed! Container may not be running properly"
    docker logs $CONTAINER_NAME
    exit 1
fi

# Clean up old images
log "Cleaning up old Docker images..."
docker image prune -f

log "🎉 Deployment completed successfully!"