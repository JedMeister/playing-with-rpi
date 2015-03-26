#!/bin/bash

# To work around memory issues I used both swap drive and a temp drive

# This is the partner script to 'work-around-ram-issues-guest.sh'
# Make sure you run this first on your host, then run the other inside
#   your guest after starting QEMU

#yes the blank lines are important! :)

cd cat>/tmp/answer.file<<EOF
n




w
EOF

if [ ! -f /tmp/swap.img ] || [ ! -f /tmp/temp.img ]; then
    IMG_NAME="swap temp"
    for IMG in $IMG_NAME; do
        IMG=/tmp/$IMG.img
        dd if=/dev/zero of="$IMG" bs=1024 count=1048576
        fdisk "$IMG" < answer.file
    done
fi
rm answer.file

#this bit assumes that $IMG=/tmp/temp.img & kpartx is installed
LOOP=$(echo $(kpartx -l "$IMG") | cut -d " " -f 1)
kpartx -a $IMG
mkfs.ext4 /dev/mapper/$LOOP
kpartx -d $IMG

echo "Now boot RPi in QEMU and run the guest part of this script"
