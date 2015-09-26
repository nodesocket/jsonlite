#!/usr/bin/env bash
set -eo pipefail; [[ $TRACE ]] && set -x

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../jsonlite.bash"
ITERATIONS=500

jsonlite_drop --force

for i in $(seq 1 $ITERATIONS); do
  ID=$(jsonlite_set '{"name":"John Doe","active":true,"permissions":{"read":true,"write":false}}')
  jsonlite_get "$ID"
  jsonlite_delete "$ID"
done
