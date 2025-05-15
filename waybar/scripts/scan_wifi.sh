#!/bin/bash

# Scan for available Wi-Fi networks
nmcli device wifi rescan

# Show available networks
nmcli device wifi list

