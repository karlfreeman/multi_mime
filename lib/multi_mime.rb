require 'multi_mime/options'

module MultiMime
  include Options
  extend self

  REQUIREMENT_MAP = [
    ['mime/types', :mime_types],
    ['mimemagic', :mimemagic],
    ['action_dispatch/http/mime_type', :mime_type],
    ['rack/mime', :rack_mime]
  ]

  # The default adapter based on what you currently
  # have loaded and installed. First checks to see
  # if any adapters are already loaded, then checks
  # to see which are installed if none are loaded.
  def default_adapter
    return :mime_types if defined?(::MIME::Types)
    return :mimemagic if defined?(::MimeMagic)
    return :mime_type if defined?(::Mime::Type)
    return :rack_mime if defined?(::Rack::Mime)
   
    REQUIREMENT_MAP.each do |(library, adapter)|
      begin
        require library
        return adapter
      rescue ::LoadError
        next
      end
    end

    Kernel.warn "[WARNING] MultiMime hasn't been able to detect an adapter"
    
    nil

  end

  # Get the current adapter class.
  def adapter
    return @adapter if defined?(@adapter) && @adapter
    self.use nil # there is no adapter
    @adapter
  end

  # Set the Mime parser utilizing a symbol, string, or class.
  # Supported by default are:
  #
  # * <tt>:mime_types</tt>
  # * <tt>:mimemagic</tt>
  # * <tt>:mime_type</tt>
  # * <tt>:rack_mime</tt>
  def use(new_adapter)
    @adapter = load_adapter(new_adapter)
  end
  alias :adapter= :use

  # Get Mime Type by extension
  #
  # @param [String] extension an extension to determine against
  # @param [Hash] options
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime Type
  def by_extension(extension, options={})
    adapter = current_adapter(options)
    adapter.by_extension(extension, options={})
  end

  private

  def current_adapter(options={})
    if new_adapter = options.delete(:adapter)
      load_adapter(new_adapter)
    else
      adapter
    end
  end

  def load_adapter(new_adapter)
    case new_adapter
    when String, Symbol
      require "multi_mime/adapters/#{new_adapter}"
      MultiMime::Adapters.const_get(:"#{new_adapter.to_s.split('_').map{|s| s.capitalize}.join('')}")
    when NilClass, FalseClass
      nil # TODO
    when Class, Module
      new_adapter
    else
      raise "Did not recognize your adapter specification. Please specify either a symbol or a class."
    end
  end

end