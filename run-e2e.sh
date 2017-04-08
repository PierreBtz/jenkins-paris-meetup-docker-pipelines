#!/usr/bin/env bash

# This is a real crude script to simulate an e2e test of our container

URL=$1
CODE=$(curl -I "$URL" 2>/dev/null | head -n 1 | cut -d$' ' -f2)

if [ "$CODE" == "200" ]; then
  exit 0
fi
exit 1
