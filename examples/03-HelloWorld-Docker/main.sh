#!/usr/bin/env bash.origin.script


echo "TEST_MATCH_IGNORE>>>"

depend {
	"docker": {
		"@com.github/bash-origin/bash.origin.docker#s1": "localhost"
	},
	"request": "@com.github/bash-origin/bash.origin.request#s1"
}


CALL_docker force_build . "org.bashorigin.php.test.03"

# TODO: Get free port dynamically
local port="8056"
CALL_docker start "org.bashorigin.php.test.03" "${port}"

echo "<<<TEST_MATCH_IGNORE"


local rid=`uuidgen`
CALL_request wait 10 200 \
	"http://$(CALL_docker echo_CONTAINER_HOST_IP):${port}/?rid=${rid}" \
	"Hello World from Dockerized PHP [${rid}]!"

echo "OK"


echo "TEST_MATCH_IGNORE>>>"

CALL_docker stop "org.bashorigin.php.test.03"
