#!/usr/bin/env bash
set -eo pipefail; [[ $TRACE ]] && set -x

VERSION="0.4.2"
CWD=$(pwd);

export JSONLITE_PATH=${JSONLITE_PATH:="$CWD/jsonlite.data"}


jsonlite_version() {
  echo "jsonlite $VERSION"
}

jsonlite_usage() {
  jsonlite_version
  echo "Usage: jsonlite COMMAND <command-specific-options>"
}

jsonlite_help() {
  jsonlite_usage
  echo
  cat<<EOF | sort | column -c2 -t -s,
  set <json>, Writes the json document and returns a document-id
  get <document-id>, Retrieves a json document by document-id
  delete <document-id>, Deletes a json document by document-id
  drop, Drops the jsonlite database
  help, Display this help message
  version, Display the version number
EOF
  echo
  echo "  For more information, see https://github.com/nodesocket/jsonlite"
  echo
}

jsonlite_is_valid_uuid() {
  if [[ "$1" =~ ^[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}$ ]]; then
    echo true
  fi

  echo false
}

jsonlite_set() {
  local value="$1"
  if [[ -z "$value" ]]; then
    echo "Missing required argument json document" 1>&2
    exit 1;
  fi

  if [[ ! -d "$JSONLITE_PATH" ]]; then
    mkdir -p "$JSONLITE_PATH"
  fi

  # Is this portable across distros?
  UUID=$(uuidgen | awk '{print toupper($0)}')

  # Piping to python -m json.tool to pretty print json is super expensive.
  # What would be a good alternative?
  echo "$value" | python -m json.tool > "$JSONLITE_PATH/$UUID"
  echo "$UUID";
}

jsonlite_get() {
  local document_id="$1"
  if [[ -z "$document_id" ]]; then
    echo "Missing required argument document id" 1>&2
    exit 2;
  fi

  VALID=$(jsonlite_is_valid_uuid "$document_id")
  if [[ "$VALID" = false ]]; then
    echo "Invalid argument document id" 1>&2
    exit 3;
  fi

  if [[ -f "$JSONLITE_PATH/$document_id" ]]; then
    cat "$JSONLITE_PATH/$document_id"
  fi
}

jsonlite_delete() {
  local document_id="$1"
  if [[ -z "$document_id" ]]; then
    echo "Missing required argument document id" 1>&2
    exit 2;
  fi

  VALID=$(jsonlite_is_valid_uuid "$document_id")
  if [[ "$VALID" = false ]]; then
    echo "Invalid argument document id" 1>&2
    exit 3;
  fi

  if [[ -f "$JSONLITE_PATH/$document_id" ]]; then
    rm -f "$JSONLITE_PATH/$document_id"
  fi
}

jsonlite_drop() {
  if [[ ! -d "$JSONLITE_PATH" ]]; then
    return $?
  fi

  if [[ "$1" == "--force" ]]; then
    rm -rf "$JSONLITE_PATH"
    return $?
  fi

  read -p "Are you sure you want to drop '$JSONLITE_PATH' (y/n)? " confirm
  case "$confirm" in
    # Do we need to guard against potentially naughty things here?
    y|Y|yes|YES ) rm -rf "$JSONLITE_PATH";;
    * ) exit 4;;
  esac
}

jsonlite_main() {
  local COMMAND="$1"
  shift 1
  case "$COMMAND" in
    "set")
      jsonlite_set "$@"
      ;;

    "get")
      jsonlite_get "$@"
      ;;

    "delete")
      jsonlite_delete "$@"
      ;;

    "drop")
      jsonlite_drop "$@"
      ;;

    "version")
      jsonlite_version
      ;;

    "help")
      jsonlite_help
      ;;

    *)
      jsonlite_help >&2
      exit 1
  esac
}

if [[ "$0" == "$BASH_SOURCE" ]]; then
  jsonlite_main "$@"
fi
