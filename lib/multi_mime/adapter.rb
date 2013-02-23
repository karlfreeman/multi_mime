require 'singleton'
require 'multi_mime/options'

module MultiMime
  class Adapter
    include Singleton
    class << self

      def foo
        instance.foo
      end

    end
  end
end