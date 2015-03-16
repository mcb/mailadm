require 'sinatra'
require_relative '../config/boot'

module Mailadm
  class App < Sinatra::Base
    set :method_override, true
  end
end

require_relative 'controllers/application_controller'
