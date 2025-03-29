#!/bin/bash

echo "===== Server Performance Stats ====="

# OS version
echo -e "\n>> OS Version:"
uname -a

# Uptime
echo -e "\n>> Uptime:"
uptime

# CPU Usage
echo -e "\n>> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

# Memory Usage
echo -e "\n>> Memory Usage:"
free -h
used=$(free | awk '/Mem:/ {print $3}')
total=$(free | awk '/Mem:/ {print $2}')
percent=$((100 * used / total))
echo "Used: $used / $total ($percent%)"

# Disk Usage
echo -e "\n>> Disk Usage:"
df -h --total | grep total

# Top 5 processes by CPU
echo -e "\n>> Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory
echo -e "\n>> Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

# Logged-in Users
echo -e "\n>> Logged in users:"
who

# Load Average
echo -e "\n>> Load Average:"
cat /proc/loadavg

# Failed Login Attempts (optional)
echo -e "\n>> Failed Login Attempts (last 50 lines):"
grep "Failed password" /var/log/auth.log | tail -n 50
