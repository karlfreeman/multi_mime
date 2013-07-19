module MultiMime
  extend self

  REQUIREMENT_MAP = [
    ["mime/types", :mime_types],
    ["mimemagic", :mimemagic],
    ["action_dispatch/http/mime_type", :mime_type],
    ["rack/mime", :rack_mime]
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

    REQUIREMENT_MAP.each do |library, adapter|
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
    self.use default_adapter # load default adapter
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
  alias :adapter= :use

  #
  def reset_adapter
    remove_instance_variable :@adapter if defined?(@adapter)
  end


  # Get mime type by mime type
  #
  # @param [String] mime_type The mime_type to determine against
  # @param [Hash] opts
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime type
  def type_for(mime_type, opts={})
    raise ArgumentError, "Mime Type must be a String. #{mime_type.inspect} given." unless mime_type.is_a? String
    adapter = current_adapter(opts)
    adapter.type_for(mime_type, opts)
  end
  alias :by_type :type_for

  # Get mime type by extension
  #
  # @param [String] extension The extension to determine against
  # @param [Hash] opts
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime type
  def type_for_extension(extension, opts={})
    raise ArgumentError, "Extension must be a String. #{extension.inspect} given." unless extension.is_a? String
    adapter = current_adapter(opts)
    adapter.type_for_extension(extension, opts)
  end
  alias :by_extension :type_for_extension

  # Get mime type by path
  #
  # @param [String] path The path to determine against
  # @param [Hash] opts
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime type
  def type_for_path(path, opts={})
    raise ArgumentError, "Path must be a String. #{path.inspect} given." unless path.is_a? String
    adapter = current_adapter(opts)
    adapter.type_for_path(path, opts)
  end
  alias :by_path :type_for_path

  # Get mime type by file
  #
  # @param [File] file The file to determine against
  # @param [Hash] opts
  #  * adapter [String] If set, the selected adapter will be used for this call.
  # @return [String] Mime type
  def type_for_file(file, opts={})
    raise ArgumentError, "File must be a File. #{file.inspect} given." unless file.is_a? File
    adapter = current_adapter(opts)
    adapter.type_for_file(file, opts)
  end
  alias :by_file :type_for_file

  private

  #
  def current_adapter(opts={})
    if new_adapter = opts.delete(:adapter)
      load_adapter(new_adapter)
    else
      self.adapter
    end
  end

  #
  def load_adapter(new_adapter)
    case new_adapter
    when String, Symbol
      require "multi_mime/adapters/#{new_adapter.to_s}"
      MultiMime::Adapters.const_get(:"#{new_adapter.to_s.split("_").map{|s| s.capitalize}.join("")}")
    when NilClass, FalseClass
      load_adapter self.default_adapter
    when Class, Module
      new_adapter
    else
      raise "Did not recognize your adapter specification. Please specify either a symbol or a class."
    end
  end

  #
  def with_adapter(new_adapter)
    old_adapter, self.adapter = adapter, new_adapter
    yield
  ensure
    self.adapter = old_adapter
  end

end