require 'mime/types' unless defined?(::MIME::Types)
require 'multi_mime/adapter'

module MultiMime
  module Adapters

    # Use the MIME::Types library
    class MimeTypes < Adapter
      def by_extension(extension, options={})
        MIME::Types.type_for(extension).first
      end
    end

  end
end