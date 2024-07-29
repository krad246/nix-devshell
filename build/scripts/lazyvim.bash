#!/usr/bin/env bash

[[ "${VERBOSE:-0}" -eq 1 ]] && set -v
[[ "${DEBUG:-0}" -eq 1 ]] && set -x

git clone https://github.com/LazyVim/starter ~/.config/nvim
