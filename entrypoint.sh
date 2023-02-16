#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

if [ ! -f /myapp/db.created ]; then
  echo "sleep for waiting for postgres to up"
  sleep 20
  
  echo "create db.created"
  touch /myapp/db.created

  echo "calling into db:create"
  rails db:create
  
  sleep 10
  echo "calling into db:migrate"
  rails db:migrate RAILS_ENV=development

  sleep 5
  echo "calling into rspec install"
  rails generate rspec:install
  
  sleep 5
  echo "creating article 1"
  rails runner "Article.create(title: 'Hello Rails and Docker', body: 'I am on Rails, Postgres and Docker')"
  echo "creating article 2"
  rails runner "Article.create(title: 'This is my 2nd title', body: 'I am happy about that')"
  #rails runner "Article.save"

  echo "***********************************************************"
  echo "*  It is about to ready to rock and roll                  *"
  echo "***********************************************************"

fi


# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"


