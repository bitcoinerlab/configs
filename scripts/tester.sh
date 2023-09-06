#!/bin/bash
# Ensures a fresh instance of the 'tester' container is always running.
# If the 'bitcoinerlab/tester' image is not found locally, it pulls the latest image.
# Any existing 'tester' containers are removed before starting a new one for a clean slate.
# Caution: The user must wait for the container to be in a ready state before using, as no sleep/delay is added in this script.
docker images | grep -q bitcoinerlab/tester || docker pull bitcoinerlab/tester; 
docker rm -f $(docker ps -a -q -f ancestor=bitcoinerlab/tester) > /dev/null 2>&1; 
docker run -d -p 8080:8080 -p 60401:60401 -p 3002:3002 bitcoinerlab/tester
