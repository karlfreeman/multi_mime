require 'singleton'
require 'multi_mime/null_type'

module MultiMime
  class Adapter
    include Singleton
    class << self
      def type_for(mime_type, opts = {})
        instance.type_for(mime_type, opts)
      end

      def type_for_extension(extension, opts = {})
        instance.type_for_extension(extension, opts)
      end

      def type_for_path(path, opts = {})
        instance.type_for_path(path, opts)
      end

      def type_for_file(file, opts = {})
        instance.type_for_file(file, opts)
      end
    end
  end
end
