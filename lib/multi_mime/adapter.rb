require 'singleton'
require 'multi_mime/options'

module MultiMime
  class Adapter
    include Singleton
    class << self
    end
  end
end