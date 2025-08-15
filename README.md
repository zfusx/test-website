# WebAuto Test Website

A simple, beautiful test website for the WebAuto deployment system.

## 🎯 Purpose

This is a minimal test website designed to validate the WebAuto auto-deployment system. It demonstrates:
- Docker containerization
- Nginx web server
- Responsive design
- Health check endpoints
- Auto-deployment via GitHub webhooks

## 🚀 Quick Start

### Local Development

```bash
# Build and run with Docker
docker build -t webauto-test-website .
docker run -p 3001:80 webauto-test-website

# Or use docker-compose
docker-compose up -d
```

Visit: http://localhost:3001

### Production Deployment

The `deploy.sh` script handles production deployment:

```bash
./deploy.sh
```

This script:
1. Pulls latest code from Git
2. Builds new Docker image
3. Stops old container
4. Starts new container
5. Performs health checks
6. Cleans up old images

## 📁 Files

- `index.html` - Main website page with responsive design
- `Dockerfile` - Container configuration
- `nginx.conf` - Nginx web server configuration
- `docker-compose.yml` - Docker Compose setup
- `deploy.sh` - Deployment script for WebAuto
- `README.md` - This file

## 🔧 Configuration

### Ports
- Container exposes port 80
- Mapped to host port 3001
- Health check available at `/health`

### Domains
Configured for:
- `web1.zfus.net` (production)
- `localhost:3001` (development)

## 🌐 Features

- **Responsive Design**: Works on desktop and mobile
- **Modern UI**: Clean, professional appearance
- **Health Checks**: Built-in health monitoring
- **Security Headers**: Basic security configurations
- **Gzip Compression**: Optimized content delivery
- **Static Asset Caching**: Performance optimization

## 🔄 WebAuto Integration

This website is designed to work with the WebAuto system:

1. **Webhook URL**: `https://wh1.zfus.net/webhook?key={site-key}`
2. **Deployment Script**: `deploy.sh`
3. **Container Management**: Automatic start/stop
4. **Health Monitoring**: Built-in health checks

## 📊 Monitoring

The website includes:
- Health check endpoint: `/health`
- Container logs via Docker
- Deployment timestamp display
- Status indicators

Perfect for testing your WebAuto deployment pipeline! 🎉