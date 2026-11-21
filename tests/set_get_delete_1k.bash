#!/usr/bin/env bash
set -eo pipefail; [[ $TRACE ]] && set -x

export JSONLITE_DATA_DIR="/tmp/jsonlite.data"
ITERATIONS=1000

jsonlite drop --force

for ((i = 0; i < ITERATIONS; i++)); do
  IFS= read -r -n 128 random_string <&3 || break
  ID=$(jsonlite set "{\"random\":\"$random_string\"}")
  jsonlite get "$ID" > /dev/null
  jsonlite delete "$ID"
done 3< <(LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom)

jsonlite drop --force
