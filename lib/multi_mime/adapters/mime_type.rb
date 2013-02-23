require 'action_dispatch/http/mime_type' unless defined?(::Mime::Type)
require 'multi_mime/adapter'

module MultiMime
  module Adapters
    # Use the Mime::Type library to look_up_extension
    class MimeType < Adapter
      def foo
        "mime_type"
      end
    end
  end
end