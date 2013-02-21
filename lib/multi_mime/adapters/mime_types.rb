require 'mime/types' unless defined?(::MIME::Types)
require 'multi_mime/adapter'

module MultiMime
  module Adapters
    # Use the MIME::Types library to look_up_extension
    class MIME::Types < Adapter
    end
  end
end