#!/bin/bash

iface="wlan0"

if [ ! -d "/sys/class/net/$iface" ]; then
  echo "↓ N/A"
  exit 0
fi

RX1=$(cat /sys/class/net/$iface/statistics/rx_bytes)
sleep 1
RX2=$(cat /sys/class/net/$iface/statistics/rx_bytes)

SPEED_KB=$(((RX2 - RX1) / 1024))

# захист від глюків ядра
[ "$SPEED_KB" -lt 0 ] && SPEED_KB=0

if [ "$SPEED_KB" -ge 1024 ]; then
  SPEED_MB=$(awk "BEGIN {printf \"%.2f\", $SPEED_KB/1024}")
  echo "↓ ${SPEED_MB} MB/s"
else
  echo "↓ ${SPEED_KB} KB/s"
fi
