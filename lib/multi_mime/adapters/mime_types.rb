require 'mime/types' unless defined?(::MIME::Types)
require 'multi_mime/adapter'

module MultiMime
  module Adapters

    # Use the MIME::Types library
    class MimeTypes < Adapter

      def type_for(mime_type, opts={})
        MIME::Types[mime_type].first
      end

      def type_for_extension(extension, opts={})
        MIME::Types.type_for(extension).first
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