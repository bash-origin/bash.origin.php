#!/usr/bin/env bash.origin.script

echo "TEST_MATCH_IGNORE>>>"

depend {
    "php": "bash.origin.php # runner/v0"
}

echo "<<<TEST_MATCH_IGNORE"


CALL_php eval '
    var_dump("Hello World");
'


echo "OK"
