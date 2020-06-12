#!/usr/bin/env bash.origin.script

echo "TEST_MATCH_IGNORE>>>"

depend {
    "php": "bash.origin.php # runner/v0",
    "request": "bash.origin.request # request/v0"
}


local port="8080"

CALL_php start ${port}


sleep 1
local rid=`uuidgen`
CALL_request expect_status 200 "http://localhost:${port}/?rid=${rid}"

echo "<<<TEST_MATCH_IGNORE"


echo "OK"

echo "TEST_MATCH_IGNORE>>>"

CALL_php stop ${port}
