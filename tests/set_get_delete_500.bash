#!/usr/bin/env bash
set -eo pipefail; [[ $TRACE ]] && set -x

export JSONLITE_PATH
JSONLITE_PATH="$(dirname "$0")/jsonlite.data"
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../jsonlite.bash"

ITERATIONS=500

jsonlite_drop --force

for i in $(seq 1 $ITERATIONS); do
  ID=$(jsonlite_set '{"name":"John Doe","active":true,"permissions":{"read":true,"write":false}}')
  jsonlite_get "$ID" > /dev/null
  jsonlite_delete "$ID"
done

jsonlite_drop --force
