# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "multi_mime/version"

Gem::Specification.new do |gem|
  gem.add_development_dependency "awesome_print"
  gem.add_development_dependency "bundler", "~> 1.0"
  gem.name          = "multi_mime"
  gem.version       = MultiMime::VERSION
  gem.authors       = ["Karl Freeman"]
  gem.email         = ["karlfreeman@gmail.com"]
  gem.license       = "MIT"
  gem.description   = %q{A generic swappable back-end for Mime::Type detection}
  gem.summary       = %q{A generic swappable back-end for Mime::Type detection}
  gem.homepage      = "https://github.com/karlfreeman/multi_mime"
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.required_ruby_version = ">= 1.9.2"
end