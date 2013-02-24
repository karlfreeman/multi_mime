require 'action_dispatch/http/mime_type' unless defined?(::Mime::Type)
require 'multi_mime/adapter'

module MultiMime
  module Adapters

    # Use the Mime::Type library
    class MimeType < Adapter

      def type_for(mime_type, opts={})
        Mime::Type.parse_data_with_trailing_star(mime_type).first
      end

      def type_for_extension(extension, opts={})
        extension = extension[/(?:.*\.)(.*$)/, 1] if extension.include?('.') # requires just the extension, without the dot
        Mime::Type.lookup_by_extension(extension)
      end

      def type_for_path(path, opts={})
        type_for_extension(File.extname(path))
      end

      def type_for_file(file, opts={})
        type_for_extension(File.extname(file))
      end

    end

  end
end