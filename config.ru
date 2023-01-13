#!/usr/bin/env -S falcon --verbose serve -c

require "dotenv/load"
require_relative "olan/app"

run Olan::App.new
