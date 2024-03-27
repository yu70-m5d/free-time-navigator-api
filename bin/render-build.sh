#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake db:migrate
bundle exec rake tags:create_tags_table
bundle exec rake tags:add_time
bundle exec rake db:seed