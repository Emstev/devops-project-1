#!/bin/bash

# Update and install dependencies
cd /home/ubuntu || exit
yes | sudo apt update
yes | sudo apt install python3 python3-pip -y

# Clone your Flask app repo
git clone https://github.com/Emstev/python-mysql-db-proj-1.git
sleep 10

# Change into project directory
cd python-mysql-db-proj-1 || exit

# Install Python dependencies
pip3 install -r requirements.txt

# Wait for the database (e.g., RDS) to be ready
echo 'Waiting for 30 seconds before starting app...'
sleep 30

# Start the app in background using nohup (more reliable than setsid)
nohup python3 app.py > app.log 2>&1 &
