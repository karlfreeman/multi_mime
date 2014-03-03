# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_mime/version'

Gem::Specification.new do |spec|
  spec.name          = 'multi_mime'
  spec.version       = MultiMime::VERSION
  spec.authors       = ['Karl Freeman']
  spec.email         = ['karlfreeman@gmail.com']
  spec.summary       = %q{A generic swappable back-end for MIME type detection}
  spec.description   = %q{A generic swappable back-end for MIME type detection}
  spec.homepage      = 'https://github.com/karlfreeman/multi_mime'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'kramdown', '>= 0.14'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'yard'
end
