#!/bin/bash
# Ensures the Bitcoinerlab Tape container is running and ready.
#
# Behavior:
# - Uses the environment variables below (or defaults if not set):
#     REGTEST_SERVER_PORT (default: 8080)
#     ELECTRUM_PORT (default: 60401)
#     ESPLORA_PORT (default: 3002)
#     ESPLORA_BLOCK_EXPLORER_PORT (default: 5123)
#     CONTAINER_NAME (default: bitcoinerlab_tester_instance)
#
# - Pulls the latest `bitcoinerlab/tape` image if needed.
# - Starts or creates the container if not already running.
# - Waits 5 seconds to ensure it's ready.

set -e

# Default values for environment variables
REGTEST_SERVER_PORT="${REGTEST_SERVER_PORT:-8080}"
ELECTRUM_PORT="${ELECTRUM_PORT:-60401}"
ESPLORA_PORT="${ESPLORA_PORT:-3002}"
ESPLORA_BLOCK_EXPLORER_PORT="${ESPLORA_BLOCK_EXPLORER_PORT:-5123}"
CONTAINER_NAME="${CONTAINER_NAME:-bitcoinerlab_tester_instance}"
VOLUME_NAME="${CONTAINER_NAME}_data"

# Check if the container is already running
if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  exit 0
fi

# Ensure latest image
docker pull bitcoinerlab/tape >/dev/null

# Start existing container if it exists, else recreate
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  docker start "${CONTAINER_NAME}" >/dev/null
else
  docker volume create "${VOLUME_NAME}" >/dev/null
  docker run -d \
    --name "${CONTAINER_NAME}" \
    -v "${VOLUME_NAME}:/root/tape-volume" \
    -p "${REGTEST_SERVER_PORT}:8080" \
    -p "${ELECTRUM_PORT}:60401" \
    -p "${ESPLORA_PORT}:3002" \
    -p "${ESPLORA_BLOCK_EXPLORER_PORT}:5000" \
    bitcoinerlab/tape >/dev/null
fi

# Wait for container readiness
sleep 5
