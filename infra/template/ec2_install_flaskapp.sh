#!/bin/bash

# Update packages and install dependencies
apt update -y
apt install -y python3-pip python3-venv git

# Clone the Flask repo
cd /home/ubuntu
git clone https://github.com/Emstev/python-mysql-db-proj-1.git
cd python-mysql-db-proj-1

# Set correct ownership
chown -R ubuntu:ubuntu /home/ubuntu/python-mysql-db-proj-1

# Set up virtual environment and install dependencies
python3 -m venv venv
source venv/bin/activate
pip install flask pymysql

# Create systemd service file
cat <<EOF > /etc/systemd/system/flaskapp.service
[Unit]
Description=Flask App Service
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/python-mysql-db-proj-1
Environment="FLASK_APP=app.py"
ExecStart=/home/ubuntu/python-mysql-db-proj-1/venv/bin/flask run --host=0.0.0.0 --port=8080
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Set correct permissions on service file
chmod 644 /etc/systemd/system/flaskapp.service

# Reload systemd and start the service
systemctl daemon-reload
systemctl enable flaskapp
systemctl start flaskapp
