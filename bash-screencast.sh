#!/bin/bash -efu

prompt() {
    printf "\033[1;34m%s \$\033[0m " "$PWD"
}

imitate_human_input() {
    local s=$1
    for (( i=0; i < ${#s}; i++ )); do
        printf "%s" "${s:$i:1}"
        sleep 0.02
    done
}

show() {
    prompt
    printf "\033[1;32m"
    imitate_human_input "$1"
    printf "\033[0m\n"
}

pause() {
    local key
    read -rsn 1 key
}

show_run() {
    prompt
    imitate_human_input "$1"
    printf "\n"
    eval "$1" || true
}

show_pause_run() {
    prompt
    imitate_human_input "$1"
    pause
    printf "\n"
    eval "$1" || true
}

. "$@"
