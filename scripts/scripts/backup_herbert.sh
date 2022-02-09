#!/bin/bash
source telegram.sh

SOURCE=/
TARGET_MNT=/media/ext_backup
TARGET_FOLDER=Backups/rsync
TODAY=$(date +%Y-%m-%d)

function rsync_wrapper {
    rsync -aAXh --stats --delete ${1} ${2} > /tmp/backup_log
    telegram_print_line "rsync from ${1} to ${2}"
    if [ "$?" -eq 1 ] ; then
        telegram_print_line "BACKUP: RSYNC Failed"
        telegram_print_line "$(cat /tmp/backup_log)"
        telegram_error_smilies
        telegram_seperator
    else
        telegram_print_line "$(head -n 2 /tmp/backup_log | tail -n 1 >> /tmp/telegram_msg)"
        telegram_print_line "$(tail -n 2 /tmp/backup_log >> /tmp/telegram_msg)"
        telegram_good_smilies
        telegram_seperator
    fi
}

function influx_wrapper {
    influxd backup -portable -database ${1} ${TARGET_MNT}/influx/${1}/${TODAY} | tee /tmp/backup_log
    if [ "$?" -eq 1 ] ; then
        telegram_print_line "BACKUP: INFLUXDB Failed"
        telegram_print_line "$(cat /tmp/backup_log)"
        telegram_error_smilies
        telegram_seperator
    else
        telegram_print_line "$(du --max-depth=1 -h ${TARGET_MNT}/influx)"
        telegram_good_smilies
        telegram_seperator
    fi
    find ${TARGET_MNT}/influx/${1}/* -mtime +7 -exec rm {} \;
}

telegram_msg_init "backup_herbert.sh"

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

    influx_wrapper homematicToInflux
    influx_wrapper tasmotaToInflux

    rsync_wrapper /home /media/ext_backup/herbert
    rsync_wrapper /media/raid6/user /media/ext_backup/raid6
    rsync_wrapper /media/raid6/share /media/ext_backup/raid6
    rsync_wrapper /media/raid6/backups /media/ext_backup/raid6
fi
# SEND TELEGRAM MSG
telegram_send_msg
telegram_cleanup