#!/bin/bash

echo "my user names is: $(whoami)"
echo "my user id is: $(id -u)"

docker buildx build --progress=plain --no-cache --build-arg USER_NAME=$(whoami) --build-arg USER_ID=$(id -u) -f $(pwd)/R/Dockerfile_R -t my-r-base .
