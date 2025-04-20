#!/bin/bash

#####################################
# script name : server stats
# description : simpel server ditailed bash script 
# author      : Ramtin Boreili
# Email       : ramtin.bor7hp@gmail.com
# version     : V1.4
#####################################


# ====== Colors ======
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# ====== Titles func ======
print_section() {
  echo -e "\n${BLUE}===== $1 =====${NC}"
}

# ====== log with Date ======
TODAY=$(date +%Y-%m-%d)
LOG_DIR="$(dirname "$0")/logs"
LOG_FILE="$LOG_DIR/$TODAY.log"

mkdir -p "$LOG_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

# ====== output ======
print_section "Server Performance Stats - $TODAY"

# CPU Usage
print_section "CPU Usage"
top -bn1 | grep "Cpu(s)" | awk '{print "'${YELLOW}'CPU Usage:'${NC}' " 100 - $8 "%"}'

# Memory Usage
print_section "Memory Usage"
free -m | awk 'NR==2{printf "'${YELLOW}'Used:'${NC}' %sMB | '${YELLOW}'Free:'${NC}' %sMB | '${YELLOW}'Usage:'${NC}' %.2f%%\n", $3, $4, $3*100/($3+$4)}'

# Disk Usage
print_section "Disk Usage"
df -h --total | grep total | awk '{print "'${YELLOW}'Used:'${NC}' " $3 " | '${YELLOW}'Free:'${NC}' " $4 " | '${YELLOW}'Usage:'${NC}' " $5}'

# Top 5 CPU-consuming processes
print_section "Top 5 Processes by CPU"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | awk '{printf "'${GREEN}'%s\t%s\t%s'${NC}'\n", $1, $2, $3}'

# Top 5 Memory-consuming processes
print_section "Top 5 Processes by Memory"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | awk '{printf "'${GREEN}'%s\t%s\t%s'${NC}'\n", $1, $2, $3}'

# System Info
print_section "System Info"
echo -e "${YELLOW}OS:${NC} $(lsb_release -d 2>/dev/null | cut -f2 || uname -a)"
echo -e "${YELLOW}Uptime:${NC} $(uptime -p)"
echo -e "${YELLOW}Load Avg:${NC} $(uptime | awk -F'load average:' '{ print $2 }')"
echo -e "${YELLOW}Logged In Users:${NC} $(who | wc -l)"

# Failed login attempts
print_section "Failed Login Attempts"
FAILED=$(grep -c "Failed password" /var/log/auth.log 2>/dev/null || echo "N/A")
echo -e "${RED}Count:${NC} $FAILED"

# ====== Commit and Push to Git ======
print_section "Git Commit"
cd "$(dirname "$0")"
git add "$LOG_FILE"
git commit -m "Daily log update for $TODAY"
git push origin main
