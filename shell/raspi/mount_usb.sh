#!/bin/bash
# mount or unmount usbstorage on raspberry pi.

if [ ! -d /mnt/usbstorage ]
then 
    sudo mkdir /mnt/usbstorage
fi

read -r -t 60 -p "mount or umount(M/N):" option
option=${option,,}
if [[ $option == "m" ]] 
then 
    sudo mount -o uid=pi,gid=pi /dev/sda1 /mnt/usbstorage
elif [[ $option == "n" ]]
then 
    sudo umount /dev/sda1
else
    echo "enter "M/N" to mount or umount device!"
fi

