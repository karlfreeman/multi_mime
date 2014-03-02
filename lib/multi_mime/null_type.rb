module MultiMime
  class NullType
    def nil?
      true
    end

    private

    def method_missing(method, *args)
      false if method.to_s[-1, 1] == '?'
    end
  end
end
