# frozen_string_literal: true

module HashCode
  class Options
    attr_accessor :help

    def verbose=(value)
      @verbose = value.present?
    end

    def verbose
      @verbose ||= false
    end

    def verbose?
      verbose.present?
    end

    def debug=(value)
      @debug = value.present?
    end

    def debug
      @debug ||= false
    end

    def debug?
      debug.present?
    end

    def [](key)
      send(key)
    end

    def []=(key, value)
      send(:"#{key}=", value)
    end
  end
end