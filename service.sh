#!/system/bin/sh
MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

swapoff /dev/block/zram0 2>/dev/null
echo 1 > /sys/block/zram0/reset 2>/dev/null

echo 2048M > /sys/block/zram0/disksize

if grep -q "zstd" /sys/block/zram0/comp_algorithm 2>/dev/null; then
    echo zstd > /sys/block/zram0/comp_algorithm
else
    echo lz4 > /sys/block/zram0/comp_algorithm
fi

mkswap /dev/block/zram0

swapon -p 32758 /dev/block/zram0

if [ -e /dev/block/zram0 ]; then
    log -t YAZM "2GB ZRAM enabled successfully"
else
    log -t YAZM "Failed to enable ZRAM"
fi
