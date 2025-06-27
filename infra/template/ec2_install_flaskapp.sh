#!/bin/bash

# Install dependencies
apt update -y
apt install -y python3.12-venv python3-pip git

# Clone the repo if it doesn't exist
cd /home/ubuntu
if [ ! -d python-mysql-db-proj-1 ]; then
  sudo -u ubuntu git clone https://github.com/Emstev/python-mysql-db-proj-1.git
fi

cd python-mysql-db-proj-1
sudo chown -R ubuntu:ubuntu .

# Setup virtual environment and install packages
sudo -u ubuntu bash -c '
  python3 -m venv venv
  ./venv/bin/pip install --upgrade pip
  ./venv/bin/pip install flask pymysql gunicorn
'

# Create systemd service file
cat <<SERVICE | sudo tee /etc/systemd/system/flaskapp.service
[Unit]
Description=Gunicorn Flask App
After=network.target

[Service]
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/python-mysql-db-proj-1
Environment="PATH=/home/ubuntu/python-mysql-db-proj-1/venv/bin"
ExecStart=/home/ubuntu/python-mysql-db-proj-1/venv/bin/gunicorn -w 4 -b 0.0.0.0:5000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
SERVICE

# Enable and start the service
systemctl daemon-reload
systemctl enable flaskapp
systemctl start flaskapp
EOF
