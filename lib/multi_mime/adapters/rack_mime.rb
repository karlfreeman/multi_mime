require 'rack/mime' unless defined?(::Rack::Mime)
require 'multi_mime/adapter'

module MultiMime
  module Adapters

    # Use the Rack::Mime library
    class RackMime < Adapter

      def by_extension(extension, options={})
        extension.insert(0, '.') unless extension[0] == '.' # requires the extension with a dot
        Rack::Mime.mime_type(extension, nil) # set the fallback to nil
      end

    end

  end
end