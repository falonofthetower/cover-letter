# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.3.0

* System dependencies

Integration tests are setup to use Poltergeist which requires PhantomJS
Instructions: https://github.com/teampoltergeist/poltergeist#installing-phantomjs 

* Configuration

First bundle with `bundle install`

There is a rake test to setup: `bundle exec rake cover_letter:setup`

This will:

1. Copy the database example to config/database.yml
2. Request a password and then set it in config/application.yml
3. Setup the database with: `rake db:setup`
4. Run the test suite with Rspec

* How to run the test suite

`bundle exec rspec`

* Deployment instructions

* ...
