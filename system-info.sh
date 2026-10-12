#!/usr/bin/env bash

# Define the log directory and log file name
mkdir -p logs

LOG_FILE="logs/sysinfo.log"

# Function containing the system information logic
get_sysinfo() {
    echo "=========================================="
    echo "  SYSTEM LOG ENTRY - $(date '+%Y-%m-%d %H:%M:%S %Z')"
    echo "=========================================="
    
    # Hostname
    echo "Hostname:         $(hostname)"
    
    # Current User
    echo "Current User:     $(whoami)"
    
    # Date/Time
    echo "Date/Time:        $(date '+%Y-%m-%d %H:%M:%S %Z')"
    
    # Operating System
    if [ -f /etc/os-release ]; then
        OS=$(grep -E '^PRETTY_NAME=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
    else
        OS=$(uname -s)
    fi
    echo "Operating System: $OS"
    
    # Kernel Version
    echo "Kernel Version:   $(uname -r)"
    
    # Uptime
    echo "Uptime:           $(uptime -p 2>/dev/null || uptime | awk -F'uptime ' '{print $2}')"
    
    # CPU Information
    CPU=$(grep -m 1 'model name' /proc/cpuinfo 2>/dev/null | cut -d ':' -f 2 | xargs)
    [ -z "$CPU" ] && CPU=$(lscpu 2>/dev/null | grep 'Model name:' | cut -d ':' -f 2 | xargs)
    echo "CPU Info:         ${CPU:-N/A}"
    
    # Memory Information
    MEM_USAGE=$(free -h 2>/dev/null | awk '/Mem:/ {print $3 " used / " $2 " total"}')
    echo "Memory Info:      ${MEM_USAGE:-N/A}"
    
    # Current Working Directory
    echo "Working Dir:      $(pwd)"
    
    echo "=========================================="
}

# Run the function, stdout is displayed on screen and written to sysinfo.log
get_sysinfo | tee -a "$LOG_FILE"


