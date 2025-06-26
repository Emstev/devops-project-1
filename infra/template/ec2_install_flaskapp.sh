#!/bin/bash
set -e

cd /home/ubuntu || exit

apt-get update -y
apt-get install -y python3 python3-pip git

echo "[+] Cloning repo..."
git clone https://github.com/Emstev/python-mysql-db-proj-1.git

cd python-mysql-db-proj-1 || exit
pip3 install --break-system-packages -r requirements.txt

echo "[+] Setting up systemd service..."
cp deployment/flaskapp.service /etc/systemd/system/flaskapp.service
chmod 644 /etc/systemd/system/flaskapp.service

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable flaskapp.service
systemctl start flaskapp.service

echo "[✓] Flask app is running as a service!"
