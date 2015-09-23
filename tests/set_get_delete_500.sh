#!/bin/bash

set -e

THIS=$(which jsonlite);
ITERATIONS=500

for i in $(seq 1 $ITERATIONS); do
    ID=$($THIS set '{"name":"John Doe","active":true,"permissions":{"read":true,"write":false}}')
    $THIS get "$ID"
    $THIS delete "$ID"
done
