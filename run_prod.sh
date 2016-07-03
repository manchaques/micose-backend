#!/bin/sh

# Build local
mix local.hex --force;
mix local.rebar --force;

# Database migration
MIX_ENV=prod mix ecto.migrate

# Launch app
PORT=4000 MIX_ENV=prod mix phoenix.server