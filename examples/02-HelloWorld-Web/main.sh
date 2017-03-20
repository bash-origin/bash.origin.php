#!/usr/bin/env bash.origin.script

echo "TEST_MATCH_IGNORE>>>"
depend {
    "php": "@com.github/bash-origin/bash.origin.php#1",
	"request": "@com.github/bash-origin/bash.origin.request#s1"
}
echo "<<<TEST_MATCH_IGNORE"



local port="8080"

CALL_php start ${port}


local rid=`uuidgen`
CALL_request wait 10 200 \
	"http://localhost:${port}/?rid=${rid}" \
	"Hello World from PHP [${rid}]!"


echo "OK"

echo "TEST_MATCH_IGNORE>>>"
CALL_php stop ${port}
