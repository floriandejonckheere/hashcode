# frozen_string_literal: true

module HashCode
  class Role
    attr_reader :name, :level, :project
    attr_accessor :contributor

    def initialize(name, level, project)
      @name = name
      @level = level
      @project = project
    end

    def compatible?(skill, mentor = nil)
      if mentor
        level < skill.level
      else
        level <= skill.level
      end
    end
  end
end
