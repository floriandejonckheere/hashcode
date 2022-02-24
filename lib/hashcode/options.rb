# frozen_string_literal: true

module HashCode
  class Options
    attr_accessor :help

    def filename=(value)
      @filename = HashCode.root.join("res/#{value}.txt")

      puts @filename
    end

    def filename
      @filename ||= HashCode.root.join("res/a_an_example.in.txt")
    end

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
