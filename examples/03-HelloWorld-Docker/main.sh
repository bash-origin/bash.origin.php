#!/usr/bin/env bash.origin.script

echo "TEST_MATCH_IGNORE>>>"
depend {
    "docker": {
				"@com.github/bash-origin/bash.origin.docker#1": "localhost"
		}
}


CALL_docker force_build . "org.bashorigin.php.test.03"

# TODO: Get free port dynamically
local port="8056"
CALL_docker start "org.bashorigin.php.test.03" "${port}"

echo "<<<TEST_MATCH_IGNORE"


sleep 2
local requestID=`uuidgen`
local command="curl -s http://${DOCKER_CONTAINER_HOST_IP}:${port}/?rid=${requestID}"

echo "TEST_MATCH_IGNORE>>>"
echo "Command: ${command}"
local response=`${command}`
echo "Response: ${response}"
echo "<<<TEST_MATCH_IGNORE"

if [ "${response}" != "Hello World from Dockerized PHP [${requestID}]!" ]; then
		echo "ERROR: Did not get expected response!"
		exit 1
fi


echo "OK"


echo "TEST_MATCH_IGNORE>>>"

CALL_docker stop "org.bashorigin.php.test.03"
