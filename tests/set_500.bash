#!/usr/bin/env bash
set -eo pipefail; [[ $TRACE ]] && set -x

export JSONLITE_PATH
JSONLITE_PATH="$(dirname "$0")/jsonlite.data"
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../jsonlite.bash"

ITERATIONS=500

jsonlite_drop --force

for i in $(seq 1 $ITERATIONS); do
  jsonlite_set '{"name":"John Doe","active":true,"permissions":{"read":true,"write":false}}' > /dev/null
done

jsonlite_drop --force
