require 'singleton'
require 'multi_mime/options'

module MultiMime
  class Adapter
    include Singleton
    class << self

      def type_for_extension(extension, options={})
        instance.type_for_extension(extension, options={})
      end

    end
  end
end