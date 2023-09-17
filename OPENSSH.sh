#!/bin/bash

# Define colors for prompt
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if input is a digit
is_digit() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    return 0  # Input is a digit
  else
    return 1  # Input is not a digit
  fi
}

# Prompt for a new port (loop until a digit is entered)
while true; do
  echo -e "${BLUE}Enter the new SSH port:${NC} "
  read -p "" new_port

  if is_digit "$new_port"; then
    break  # Exit the loop when a digit is entered
  else
    echo -e "${RED}Invalid input. Please enter a numeric value.${NC}"
  fi
done

# Construct the sed command to replace the DEFAULT_HOST port in wsproxy.py
sed_command_wsproxy="s/DEFAULT_HOST = \"127.0.0.1:[0-9]*\"/DEFAULT_HOST = \"127.0.0.1:$new_port\"/"

# Use sed to modify the wsproxy.py script
sudo sed -i "$sed_command_wsproxy" /etc/VPSManager/wsproxy.py

# Construct the sed command to replace the DEFAULT_HOST port in proxy.py
sed_command_proxy="s/DEFAULT_HOST = '0.0.0.0:[0-9]*'/DEFAULT_HOST = '0.0.0.0:$new_port'/"

# Use sed to modify the proxy.py script
sudo sed -i "$sed_command_proxy" /etc/VPSManager/proxy.py

# Display a colorful message
echo -e "${GREEN}OPENSSH PORT updated to: $new_port${NC}"

# Schedule a system reboot after a 10-second delay
countdown=10
echo -e "${BLUE}Rebooting the system in $countdown seconds...${NC}"

# Countdown loop
while [ $countdown -gt 0 ]; do
  echo -e "${BLUE}Time remaining: $countdown seconds...${NC}"
  sleep 1
  countdown=$((countdown - 1))
done

# Reboot the system
echo -e "${GREEN}Rebooting the system now...${NC}"
sudo shutdown -r now
