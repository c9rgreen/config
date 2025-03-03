#!/usr/bin/env bash

npx depcruise src \
  --affected \
  $REVIEW_BASE \
  --output-type dot \
  | dot -T svg | chafa

