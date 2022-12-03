#!/bin/bash

TMP_FILE=/tmp/telegram_msg
token=$(head -n 1 ~/.telegram)
chatid=$(tail -n 1 ~/.telegram)


function telegram_send_msg {
    curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --data "{\"chat_id\": \"$chatid\", \"text\": \"$(cat $TMP_FILE)\"}" \
        https://api.telegram.org/bot${token}/sendMessage
}

function telegram_cleanup {
    rm "${TMP_FILE}"
}

function telegram_cleanup {
    rm "${TMP_FILE}"
}

function telegram_seperator {
    echo "-------" >> "${TMP_FILE}"
}

function telegram_msg_init {
    echo -n "from: " >> "${TMP_FILE}"
    cat /etc/hostname >> "${TMP_FILE}"
    echo "script: ${1}" >> "${TMP_FILE}"
    telegram_seperator
}

function telegram_error_smilies {
    printf "\xE2\x9D\x8C\xE2\x9D\x8C\xE2\x9D\x8C\xE2\x9D\x8C\xE2\x9D\x8C\xE2\x9D\x8C\xE2\x9D\x8C\n" >> /tmp/telegram_msg
}

function telegram_good_smilies {
    printf "\xE2\x9C\x85\xE2\x9C\x85\xE2\x9C\x85\xE2\x9C\x85\xE2\x9C\x85\xE2\x9C\x85\xE2\x9C\x85\n" >> /tmp/telegram_msg
}

function telegram_seperator {
    echo "-------" >> "${TMP_FILE}"
}

function telegram_print {
    echo -n $1 >> "${TMP_FILE}"
}

function telegram_print_line {
    echo $1 >> "${TMP_FILE}"
}