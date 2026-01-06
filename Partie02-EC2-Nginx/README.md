# Partie 02 – EC2 & Nginx Deployment

## Objective
Deploy and expose a static frontend on the internet using an AWS EC2 instance and Nginx web server.

## EC2 Configuration
- Operating System: Ubuntu Server 22.04 LTS
- Instance Type: t2.micro
- Access: SSH using key-based authentication
- Security Group:
  - Port 22 (SSH)
  - Port 80 (HTTP)
  - Port 443 (HTTPS – optional)

## Web Server
- Nginx installed on Ubuntu
- Default web root: /var/www/html
- Static frontend served via HTTP

## Result
The frontend is accessible through the public IP address of the EC2 instance.
