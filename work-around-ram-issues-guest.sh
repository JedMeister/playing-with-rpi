#!/bin/bash

# This is the partner script to work-around-ram-issues-host.sh
# Make suer you have run that first on your host.

# This needs to be run in RPi (QEMU guest)

mkswap /dev/sdb1
swapon /dev/sdb1
umount /tmp
mount /dev/sdc1 /tmp

