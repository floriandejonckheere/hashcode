# frozen_string_literal: true

module HashCode
  class Skill
    attr_reader :name, :contributor
    attr_accessor :level

    def initialize(name, level, contributor)
      @name = name
      @level = level
      @contributor = contributor
    end
  end
end
