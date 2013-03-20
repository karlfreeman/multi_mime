require 'mimemagic' unless defined?(::Mimemagic)
require 'multi_mime/adapter'
require 'multi_mime/null_type'

module MultiMime
  module Adapters

    # Use the Mimemagic library
    class Mimemagic < Adapter

      def type_for(mime_type, opts={})
        type = MimeMagic::EXTENSIONS.key(mime_type) # Mimemagic actually doesnt allow you to simply verify that a mime type exists
        type ? mime_type : MultiMime::NullType.new
      end

      def type_for_extension(extension, opts={})
        MimeMagic.by_extension(extension) || MultiMime::NullType.new
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