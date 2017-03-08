#!/usr/bin/env bash.origin.script

if ! BO_has php; then
		echo >&2 "ERROR: 'php' command not found!"
		exit 1
fi

function EXPORTS_eval {
		php -r "$1"
}

function EXPORTS_start {
		php -S "localhost:${1}" &
}

function EXPORTS_stop {
		ps -ef | grep "${1}" | grep -v grep | awk '{print $2}' | xargs kill -9
}
