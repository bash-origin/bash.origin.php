#!/usr/bin/env bash.origin.script

echo "TEST_MATCH_IGNORE>>>"
depend {
    "php": "@com.github/bash-origin/bash.origin.php#1"
}
echo "<<<TEST_MATCH_IGNORE"


CALL_php eval '
    var_dump("Hello World");
'


echo "OK"
