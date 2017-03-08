#!/usr/bin/env bash.origin.script

echo "TEST_MATCH_IGNORE>>>"
depend {
    "php": "@com.github/bash-origin/bash.origin.php#1"
}
echo "<<<TEST_MATCH_IGNORE"



local port="8080"

CALL_php start ${port}


sleep 1
local requestID=`uuidgen`
local command="curl -s http://localhost:${port}/?rid=${requestID}"
echo "Command: ${command}"


echo "TEST_MATCH_IGNORE>>>"
local response=`${command}`
echo "Response: ${response}"
echo "<<<TEST_MATCH_IGNORE"

if [ "${response}" != "Hello World from PHP [${requestID}]!" ]; then
		echo "ERROR: Did not get expected response!"
		exit 1
fi


echo "OK"

echo "TEST_MATCH_IGNORE>>>"
CALL_php stop ${port}
