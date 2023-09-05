#!/bin/bash
docker images | grep -q bitcoinerlab/tester || docker pull bitcoinerlab/tester; docker rm -f $(docker ps -a -q -f ancestor=bitcoinerlab/tester) > /dev/null 2>&1; docker run -d -p 8080:8080 -p 60401:60401 -p 3002:3002 bitcoinerlab/tester

