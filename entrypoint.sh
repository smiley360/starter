#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

echo "sleep for waiting for postgres to up"
sleep 25
echo "done sleeping"
if [ ! -f /myapp/db.created ]; then
  echo "calling into db:create"
  rails db:create
  touch /myapp/db.created
  sleep 10
  echo "calling into db:migrate"
  rails db:migrate RAILS_ENV=development
  sleep 10
  rails runner "Article.create(title: 'Hello Rails and Docker', body: 'I am on Rails, Postgres and Docker!')"
  rails runner "Article.save"
fi


# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"


