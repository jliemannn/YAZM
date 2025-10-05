#!/system/bin/sh

swapoff /dev/block/zram0 2>/dev/null
echo 1 > /sys/block/zram0/reset 2>/dev/null

log -t YAZM "ZRAM disabled and module uninstalled"
