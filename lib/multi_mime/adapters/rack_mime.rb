require 'rack/mime' unless defined?(::Rack::Mime)
require 'multi_mime/adapter'

module MultiMime
  module Adapters
    # Use the Rack::Mime library to look_up_extension
    class Rack::Mime < Adapter
    end
  end
end