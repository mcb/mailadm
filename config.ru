#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start the App,
# just execute it from the command line.

require File.expand_path("../app/app.rb", __FILE__)

run Rack::URLMap.new("/"  => Mailadm::ApplicationController)
