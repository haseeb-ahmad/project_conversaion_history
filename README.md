# Project Conversations History

This project is a Ruby on Rails application designed to manage project conversations and history.

## Prerequisites

- Ruby version: `3.4.1`
- PostgreSQL

## System Dependencies

- curl
- libjemalloc2
- libvips
- postgresql-client

## Configuration

To configure the database, run the following command:
bin/rails db:create

bin/rails db:migrate

rails assets:precompile

rails s