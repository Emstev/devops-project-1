#!/bin/bash

set -e  # Exit on error

cd /home/ubuntu
yes | sudo apt update
yes | sudo apt install python3 python3-pip python3.12-venv git

# Clone the project
git clone https://github.com/Emstev/python-mysql-db-proj-1.git
cd python-mysql-db-proj-1

# Ensure setup-env.sh is executable
chmod +x setup-env.sh

# Run environment setup
./setup-env.sh

# Start the app in background
echo 'Waiting for 5 seconds before running the app.py'
sleep 5
source venv/bin/activate
setsid python3 -u app.py > app.log 2>&1 &
