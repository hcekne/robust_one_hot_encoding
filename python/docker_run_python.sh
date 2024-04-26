#!/bin/bash

echo "my user names is: $(whoami)"
echo "my user id is: $(id -u)"

docker run -d --name python-dev-encoding -v $(pwd)/app:/home/$(whoami)/app python-base-encoding
