#!/usr/bin/env bash

[[ "${VERBOSE:-0}" -eq 1 ]] && set -v
[[ "${DEBUG:-0}" -eq 1 ]] && set -x

git config --global core.fsmonitor true
git config --global core.untrackedcache true
git config --global feature.manyFiles true

git config --global core.packedGitLimit 1024m
git config --global core.packedGitWindowSize 1024m
git config --global pack.deltaCacheSize 2047m
git config --global pack.packSizeLimit 4095m
git config --global pack.windowMemory 4095m

git config --global core.fileMode false
git config --global core.autocrlf false
git config --global fetch.parallel 0
git config --global pull.rebase true
git config --global push.autoSetupRemote true

git config --global safe.directory '*'
