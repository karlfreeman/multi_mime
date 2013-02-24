require 'mimemagic' unless defined?(::Mimemagic)
require 'multi_mime/adapter'

module MultiMime
  module Adapters

    # Use the Mimemagic library
    class Mimemagic < Adapter

      def type_for(mime_type, opts={})
        type = MimeMagic::EXTENSIONS.key(mime_type) # Mimemagic actually doesnt allow you to simply verify that a mime type exists
        type ? mime_type : nil
      end

      def type_for_extension(extension, opts={})
        MimeMagic.by_extension(extension)
      end

    end

  end
end