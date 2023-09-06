#!/bin/bash
# Checks if the 'tester' container is running.
# If not, pulls the latest 'bitcoinerlab/tester' image and starts a new container.
# Introduces a 5-second sleep after starting the container for the first time to ensure consistent readiness.
# The sleep ensures that, regardless of whether the user knows the initial state of the container (running or not),
# the script always returns with the container in a similarly ready state.
docker ps | grep bitcoinerlab/tester > /dev/null || (docker pull bitcoinerlab/tester && docker run -d -p 8080:8080 -p 60401:60401 -p 3002:3002 bitcoinerlab/tester && sleep 5)
