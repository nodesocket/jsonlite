#!/bin/bash

set -e
THIS=$(which jsonlite);

for i in $(seq 1 1000); do
    ID=$($THIS set '{"name":"John Doe","active":true,"permissions":{"read":true,"write":false}}')
    $THIS get "$ID"
    $THIS delete "$ID"
done
