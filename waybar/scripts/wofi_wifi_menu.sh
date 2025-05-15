#!/bin/bash

# Rescan Wi-Fi networks
nmcli device wifi rescan >/dev/null 2>&1
sleep 1

# Get list of unique SSIDs
SSID=$(nmcli -f SSID device wifi list | awk 'NR>1 && $1!="" {print $1}' | uniq | wofi --dmenu --prompt="Select Wi-Fi")

# Exit if no selection
[ -z "$SSID" ] && exit

# Prompt for password (masked)
PASS=$(wofi --dmenu --password --prompt="Password for $SSID")

# Exit if no password entered
[ -z "$PASS" ] && exit

# Connect using nmcli
if nmcli device wifi connect "$SSID" password "$PASS"; then
  notify-send "Connected to $SSID"
else
  notify-send "Failed to connect to $SSID"
fi

