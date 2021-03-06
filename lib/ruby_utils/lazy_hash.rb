module RubyUtils
  class LazyHash < Hash
    attr_accessor :args

    def initialize (*args)
      self.args = args
    end

    def [] (key)
      value = super
      if value.is_a?(Proc)
        value     = evaluate(value)
        self[key] = value
      end
      value
    end

    private

    def evaluate (proc)
      proc.call(*args)
    end
  end
end

LazyHash = RubyUtils::LazyHash
