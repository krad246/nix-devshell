#!/usr/bin/env bash

find "$WORKDIR" -name .envrc -exec direnv allow {} \;
echo "$@"
