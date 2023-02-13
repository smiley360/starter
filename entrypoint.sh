#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

if [ ! -f /myapp/db.created ]; then
  rails db:create
  touch /myapp/db.created
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
