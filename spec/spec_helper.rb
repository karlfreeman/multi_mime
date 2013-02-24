require 'bundler'
Bundler.setup
begin; require 'awesome_print'; rescue LoadError; end

require 'rspec'
require 'support/pry'
require 'support/simplecov'
require 'shared/adapter'
require 'multi_mime'

#
RSpec.configure do |config|
end