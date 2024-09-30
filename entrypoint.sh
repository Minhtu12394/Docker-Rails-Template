#!/bin/bash
set -e
bundle check || bundle install --binstubs="$BUNDLE_BIN"

rm -f tmp/pids/server.pid
bundle exec rails s -p 3000 -b 0.0.0.0
