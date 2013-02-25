source 'https://rubygems.org'

gem 'rake', '>= 1.2'
gem 'yard'

# platforms :ruby_18 do
# end
# platforms :ruby, :mswin, :mingw do
# end
# platforms :jruby do
# end

gem 'mime-types', :require => false
gem 'actionpack', '>= 3.2', :require => false
gem 'rack', :require => false
gem 'mimemagic', :require => false

group :development do
  gem 'kramdown', '>= 0.14'
  gem 'pry'
  gem 'pry-debugger', :platforms => :mri_19
end

group :test do
  gem 'rspec'
  gem 'fakefs', :require => 'fakefs/safe'
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
end

gemspec