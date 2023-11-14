#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake db:migrate
bundle exec rake get_places:get_spots
bundle exec rake get_places:get_placeid