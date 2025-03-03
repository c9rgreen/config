#!/usr/bin/env bash

FILES=$(git diff --name-only $(git merge-base HEAD "$REVIEW_BASE") \
  | tr '\n' ' ' \
  | sed 's/ /|/g; s/|*$//; s/\./\\./g; s/\//\\\//g')


npx depcruise \
  --include-only "$FILES" \
  --output-type dot src \
  | dot -T svg | chafa

