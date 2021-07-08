#!/bin/sh

set -e

if [ "$1" = "--test" ]; then
  toml_update
  [ -n "$CONF_UPDATE" ] && cat "$CONF_UPDATE"
  exit 0
fi
toml_update > /dev/null

/entrypoint.sh $@