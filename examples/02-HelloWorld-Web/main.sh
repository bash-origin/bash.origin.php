#!/usr/bin/env bash.origin.script

echo "TEST_MATCH_IGNORE>>>"

depend {
    "php": "@com.github/bash-origin/bash.origin.php#1",
	"request": "@com.github/bash-origin/bash.origin.request#s1"
}


local port="8080"

CALL_php start ${port}


sleep 1
local rid=`uuidgen`
CALL_request expect_status 200 "http://localhost:${port}/?rid=${rid}"

echo "<<<TEST_MATCH_IGNORE"


echo "TEST_MATCH_IGNORE>>>"

CALL_php stop ${port}

echo "<<<TEST_MATCH_IGNORE"

echo "OK"
