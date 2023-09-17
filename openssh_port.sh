#!/bin/bash

# Prompt for a new port
read -p "Enter the new port: " new_port

# Construct the sed command to replace the DEFAULT_HOST port in wsproxy.py
sed_command_wsproxy="s/DEFAULT_HOST = \"127.0.0.1:[0-9]*\"/DEFAULT_HOST = \"127.0.0.1:$new_port\"/"

# Use sed to modify the wsproxy.py script
sudo sed -i "$sed_command_wsproxy" /etc/VPSManager/wsproxy.py

# Construct the sed command to replace the DEFAULT_HOST port in proxy.py
sed_command_proxy="s/DEFAULT_HOST = '0.0.0.0:[0-9]*'/DEFAULT_HOST = '0.0.0.0:$new_port'/"

# Use sed to modify the proxy.py script
sudo sed -i "$sed_command_proxy" /etc/VPSManager/proxy.py

echo "OPENSSH PORT updated to: $new_port"



