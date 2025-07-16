#!/bin/bash
LEASE_FILE="/var/lib/misc/dnsmasq.leases"
LOG_FILE="/var/log/pxe-discovery.log"

touch "$LOG_FILE"
tail -F "$LEASE_FILE" | while read line; do
  IP=$(echo "$line" | awk '{print $3}')
  MAC=$(echo "$line" | awk '{print $2}')
  HOST=$(echo "$line" | awk '{print $4}')
  TIME=$(date '+%Y-%m-%d %H:%M:%S')

  if ! grep -q "$MAC" "$LOG_FILE"; then
    echo "$TIME New PXE Client -> MAC: $MAC | IP: $IP | Host: $HOST" >> "$LOG_FILE"
  fi
done