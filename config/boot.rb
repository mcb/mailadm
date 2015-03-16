require 'pry'
require 'yaml'
require 'logger'
require 'securerandom'
require 'sequel'
require 'unix_crypt'

module Mailadm
end

require_relative '../lib/util'
require_relative 'database'
require_relative '../app/models/user'
require_relative '../app/models/alias'
require_relative '../app/models/domain'


