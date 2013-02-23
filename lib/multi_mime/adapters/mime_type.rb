require 'action_dispatch/http/mime_type' unless defined?(::Mime::Type)
require 'multi_mime/adapter'

module MultiMime
  module Adapters

    # Use the Mime::Type library
    class MimeType < Adapter
      def by_extension(extension, options={})
        extension = extension[/(?:.*\.)(.*$)/, 1] if extension.include?('.') # requires just the extension, without the dot
        Mime::Type.lookup_by_extension(extension)
      end
    end

  end
end