$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'bundler'
Bundler.setup

%w(support shared).each do |dir|
  Dir.glob(File.expand_path("../#{dir}/**/*.rb", __FILE__), &method(:require))
end

require 'multi_mime'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def jruby?
  defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby'
end

def undefine_constants(*consts)
  values = {}
  consts.each do |const|
    if Object.const_defined?(const)
      values[const] = Object.const_get(const)
      Object.send :remove_const, const
    end
  end
  yield
ensure
  values.each do |const, value|
    Object.const_set const, value
  end
end
