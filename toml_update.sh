#!/bin/sh

set -e

toml_update > /dev/null
if [ "$1" = "--test" ]; then
  cat $CONF_UPDATE
  exit 0
fi

/entrypoint.sh $@