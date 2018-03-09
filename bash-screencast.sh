#!/bin/bash -efu

ROOTDIR=$PWD
prompt() {
    local pwd=$PWD
    case "$pwd" in
    "$ROOTDIR")
        pwd="~";;
    "$ROOTDIR"/*)
        pwd="~"${pwd#"$ROOTDIR"};;
    esac
    printf "\033[1;34m%s \$\033[0m " "$pwd"
}

imitate_human_input() {
    local s=$1
    for (( i=0; i < ${#s}; i++ )); do
        printf "%s" "${s:$i:1}"
        sleep 0.02
    done
}

pause() {
    local key
    while true; do
        read -rsn 1 key
        if [ "$key" = "x" ]; then
            printf "\n%s\n" "--- PAUSE ---"
            bash -i || true
            printf "%s" "--- RESUME ---"
            continue
        fi
        break
    done
}

show() {
    prompt
    printf "\033[1;32m"
    imitate_human_input "$1"
    printf "\033[0m"
    pause
    printf "\n"
}

run() {
    prompt
    imitate_human_input "$1"
    pause
    printf "\n"
    eval "$1" || true
}

. "$@"
