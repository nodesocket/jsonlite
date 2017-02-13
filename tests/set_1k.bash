#!/usr/bin/env bash
set -eo pipefail; [[ $TRACE ]] && set -x

export JSONLITE_DATA_DIR="/tmp/jsonlite.data"
ITERATIONS=1000

jsonlite drop --force

for i in $(seq 1 $ITERATIONS); do
  jsonlite set '{"name":"John Doe","active":true,"permissions":{"read":true,"write":false}}' > /dev/null
done

jsonlite drop --force
