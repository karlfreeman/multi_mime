require 'mimemagic' unless defined?(::Mimemagic)
require 'multi_mime/adapter'

module MultiMime
  module Adapters

    # Use the Mimemagic library
    class Mimemagic < Adapter
      def by_extension(extension, options={})
        MimeMagic.by_extension(extension)
      end
    end

  end
end