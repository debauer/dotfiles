#!/bin/bash
source telegram.sh

SOURCE=/
TARGET_MNT=/media/backup
TARGET_FOLDER=Backups/rsync
TODAY=$(date +%Y-%m-%d)

telegram_msg_init "system backup"

sudo mount -a | grep "${TARGET_MNT}"
findmnt $TARGET_MNT
if [ "$?" -eq 1 ] ; then
    telegram_print "mountpoint: "
    telegram_print_line $TARGET_MNT
    telegram_print_line "hdd not present"
    telegram_error_smilies
else
    echo $LINE
    echo "BACKUP: start rsync"
    SUB_FOLDER=home
    sudo rsync -aAXh -v --stats --progress --exclude={"*/.cache", "*/.local"} "${SOURCE}/${SUB_FOLDER}" "${TARGET_MNT}/${TARGET_FOLDER}/${TODAY}/" > /tmp/backup_log_${SUB_FOLDER}
    #sudo rsync -aAXh -v --stats --progress --exclude={"/usr/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","*/.cache"} "${SOURCE}" "${TARGET_MNT}/${TARGET_FOLDER}/${TODAY}" > /tmp/backup_log
    if [ "$?" -eq 1 ] ; then
        telegram_print_line "BACKUP: RSYNC Failed"
        telegram_seperator
        telegram_print_line "$(cat /tmp/backup_log)"
        telegram_seperator
        telegram_error_smilies
    fi
    telegram_print_line "$(head -n 6 /tmp/backup_log | tail -n 5 >> /tmp/telegram_msg)"
    telegram_print_line "$(tail -n 2 /tmp/backup_log >> /tmp/telegram_msg)"
    telegram_good_smilies

fi
# SEND TELEGRAM MSG
#telegram_send_msg
telegram_cleanup
