#!/bin/bash

set -e

VERSION="0.4.3"
COMMAND=$1
CWD=$(pwd);

function is_valid_uuid {
    if [[ $1 =~ ^[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}$ ]]; then
        echo true
    fi

    echo false
}

case "$COMMAND" in
    "set")

        if [ -z "$2" ]; then
            printf "Missing required argument json document"
            exit 1;
        fi

        if [ ! -d "$CWD/jsonlite.data" ]; then
            mkdir "$CWD/jsonlite.data"
        fi

        # Is this portable across distros?
        UUID=$(uuidgen | awk '{print toupper($0)}')

        # Using json_reformat from YAJL to pretty print json.
        echo "$2" | json_reformat > "$CWD/jsonlite.data/$UUID"
        echo "$UUID";

        ;;

    "get")

        if [ -z "$2" ]; then
            printf "Missing required argument document id"
            exit 2;
        fi

        VALID=$(is_valid_uuid "$2")
        if [ "$VALID" = false ]; then
            printf "Invalid argument document id"
            exit 3;
        fi

        if [ -f "$CWD/jsonlite.data/$2" ]; then
            cat "$CWD/jsonlite.data/$2"
        fi

        ;;

    "delete")

        if [ -z "$2" ]; then
            printf "Missing required argument document id"
            exit 2;
        fi

        VALID=$(is_valid_uuid "$2")
        if [ "$VALID" = false ]; then
            printf "Invalid argument document id"
            exit 3;
        fi

        if [ -f "$CWD/jsonlite.data/$2" ]; then
            rm -f "$CWD/jsonlite.data/$2"
        fi

        ;;

    "drop")

        if [ -d "$CWD/jsonlite.data" ]; then
            read -p "Are you sure you want to drop '$CWD/jsonlite.data' (y/n)? " confirm
            case "$confirm" in
                # Do we need to guard against potentially naughty things here?
                y|Y|yes|YES ) rm -rf "$CWD/jsonlite.data";;
                * ) exit 4;;
            esac
        fi

        ;;

    "version")

        printf "%s" "$VERSION"

    esac
