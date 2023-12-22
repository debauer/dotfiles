mkdir /mnt/arch
mount /dev/mapper/system -o subvolid=256 /mnt/arch
sleep 1
mount /dev/mapper/system -o subvolid=257 /mnt/arch/home
mount /dev/mapper/system -o subvolid=258 /mnt/arch/var/log
mount /dev/mapper/system -o subvolid=259 /mnt/arch/var/cache/pacman/pkg
