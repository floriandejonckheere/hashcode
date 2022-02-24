# frozen_string_literal: true

module HashCode
  class Contributor
    attr_reader :name
    attr_accessor :skills

    def initialize(name, skills = [])
      @name = name
      @skills = skills
    end

    def skill?(skill_name, level)
      skills.any? { |sk| sk.name == skill_name && sk.level >= level }
    end

    def eligible(projects)
      roles_with_diff = projects.flat_map do |project|
        # TODO: order by min(skill level) > role level
        # TODO: optimize by mentoring
        project.roles.filter_map do |r|
          skill = skills.find { |s| s.name == r.name && s.level >= r.level }

          next unless skill

          diff = r.level - skill.level

          [r, diff]
        end
      end

      roles_with_diff
        .sort_by { |_k, v| v }
        .first
        .first
    end

    def ==(other)
      name == other.name
    end
  end
end
