#!/usr/bin/env bash

$EDITOR  -c 'tabdo Gdiff '${1:-$REVIEW_BASE} $(git diff --name-only --diff-filter=AM ${1:-$REVIEW_BASE}) -p
