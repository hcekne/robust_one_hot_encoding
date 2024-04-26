#!/bin/bash

echo "my user names is: $(whoami)"
echo "my user id is: $(id -u)"

docker run -d --name my-r-dev -v $(pwd)/app:/home/$(whoami)/app my-r-base
