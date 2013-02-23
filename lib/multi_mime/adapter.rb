require 'singleton'
require 'multi_mime/options'

module MultiMime
  class Adapter
    include Singleton
    class << self

      def by_extension(string, options={})
        instance.by_extension(string, options={})
      end

    end
  end
end