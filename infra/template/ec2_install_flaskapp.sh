#!/bin/bash
set -e

# Make sudo passwordless for ubuntu and jenkins users (adjust if needed)
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

cd /home/ubuntu || exit

# Install required packages
apt-get update -y
apt-get install -y python3 python3-pip git

# Clone your Flask app repo
echo "[+] Cloning repo..."
git clone https://github.com/Emstev/python-mysql-db-proj-1.git

cd python-mysql-db-proj-1 || exit

# Install Python dependencies
pip3 install --break-system-packages -r requirements.txt

# Register Flask app as a systemd service
echo "[+] Setting up systemd service..."
cp deployment/flaskapp.service /etc/systemd/system/flaskapp.service
chmod 644 /etc/systemd/system/flaskapp.service

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable flaskapp.service
systemctl start flaskapp.service

echo "[✓] Flask app is running as a service!"
