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
  end
end
