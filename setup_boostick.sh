#!/bin/bash

if [[ ! -f "$1" ]]; then
	echo "ISO file not found"
	exit 0
fi

if [[ ! -b "$2" ]]; then
	echo "File system does not exist"
	exit 0
fi

umount "$2"
echo "Formating usbstick"
if [[ "$3" = "-z" ]]; then
	echo "	Filling zeros to usbstick"
	dd if=/dev/zero of=$"2" bs=4096
fi

echo "	Making usbstick Fat32"
mkfs -t vfat "$2"

dd if="$1" of="$2" bs=4096 && sync

if [[ $? -eq 0 ]]; then
	echo "The process ended correctly"
	exit 0
fi

echo "USBstick could not be prepared"
exit 0
