# frozen_string_literal: true

module HashCode
  class Role
    attr_reader :skill, :level, :project

    def initialize(skill, level, project)
      @skill = skill
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
