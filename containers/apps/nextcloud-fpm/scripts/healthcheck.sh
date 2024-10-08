#!/bin/sh

REQUEST_METHOD="GET" \
SCRIPT_NAME="status.php" \
SCRIPT_FILENAME="status.php" \
cgi-fcgi -bind -connect "127.0.0.1:9000" | grep -q '"installed":true' || exit 1
