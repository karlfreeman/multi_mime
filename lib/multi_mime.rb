module MultiMime
  class Error < StandardError; end
  class AdapterError < Error; end
  class DefaultAdapterError < Error; end

  extend self

  REQUIREMENT_MAP = [
    [:mime_types, 'mime/types', :MIME].freeze,
    [:mimemagic, 'mimemagic', :MimeMagic].freeze,
    [:mime_type, 'action_dispatch/http/mime_type', :Mime].freeze,
    [:rack_mime, 'rack/mime', :Rack].freeze
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

    REQUIREMENT_MAP.each do |adapter, library, clazz|
      begin
        require library
        return adapter
      rescue ::LoadError
        next
      end
    end
    fail DefaultAdapterError, 'MultiMime hasn\'t been able to detect a default_adapter'
    nil
  end

  # Get the current adapter class.
  def adapter
    return @adapter if defined?(@adapter) && @adapter
    use default_adapter # load default adapter
    @adapter
  end

  # Set the Mime parser utilizing a symbol, string, or class.
  #
  # @param [Symbol, String, Class] new_adapter
  #  * mime_types
  #  * mimemagic
  #  * mime_type
  #  * rack_mime
  def use(new_adapter)
    @adapter = load_adapter(new_adapter)
  end
  alias_method :adapter=, :use

  # Remove the currently loaded adapter
  def reset_adapter
    remove_instance_variable :@adapter if defined?(@adapter)
  end

  # Get mime type by mime type
  #
  # @param [String] mime_type The mime_type to determine against
  # @param [Hash] opts
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime type
  def type_for(mime_type, opts = {})
    fail ArgumentError, "Mime Type must be a String. #{mime_type.inspect} given." unless mime_type.is_a? String
    adapter = current_adapter(opts)
    adapter.type_for(mime_type, opts)
  end
  alias_method :by_type, :type_for

  # Get mime type by extension
  #
  # @param [String] extension The extension to determine against
  # @param [Hash] opts
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime type
  def type_for_extension(extension, opts = {})
    fail ArgumentError, "Extension must be a String. #{extension.inspect} given." unless extension.is_a? String
    adapter = current_adapter(opts)
    adapter.type_for_extension(extension, opts)
  end
  alias_method :by_extension, :type_for_extension

  # Get mime type by path
  #
  # @param [String] path The path to determine against
  # @param [Hash] opts
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime type
  def type_for_path(path, opts = {})
    fail ArgumentError, "Path must be a String. #{path.inspect} given." unless path.is_a? String
    adapter = current_adapter(opts)
    adapter.type_for_path(path, opts)
  end
  alias_method :by_path, :type_for_path

  # Get mime type by file
  #
  # @param [File] file The file to determine against
  # @param [Hash] opts
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime type
  def type_for_file(file, opts = {})
    fail ArgumentError, "File must be a File. #{file.inspect} given." unless file.is_a? File
    adapter = current_adapter(opts)
    adapter.type_for_file(file, opts)
  end
  alias_method :by_file, :type_for_file

  private

  def current_adapter(opts = {})
    if new_adapter = opts.delete(:adapter)
      load_adapter(new_adapter)
    else
      adapter
    end
  end

  def load_adapter(new_adapter)
    case new_adapter
    when String, Symbol
      adapter_clazz = nil
      REQUIREMENT_MAP.each do |adapter, library, clazz|
        if new_adapter.to_sym == adapter
          require library
          require "multi_mime/adapters/#{new_adapter}"
          adapter_clazz = MultiMime::Adapters.const_get(:"#{new_adapter.to_s.split('_').map { |s| s.capitalize }.join('')}")
        else
          next
        end
      end
      if adapter_clazz.nil?
        fail AdapterError, "MultiMime hasn't been able to load adapter #{new_adapter}"
        load_adapter nil
      else
        return adapter_clazz
      end
    when NilClass, FalseClass
      load_adapter default_adapter
    when Class, Module
      new_adapter
    else
      fail 'Did not recognize your adapter specification. Please specify either a symbol or a class.'
    end
  end

  def with_adapter(new_adapter)
    old_adapter, self.adapter = adapter, new_adapter
    yield
  ensure
    self.adapter = old_adapter
  end
end
