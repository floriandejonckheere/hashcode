# frozen_string_literal: true

module HashCode
  class Project
    attr_reader :name, :days, :score, :best_before
    attr_accessor :roles, :start_time

    def initialize(name, days, score, best_before, roles = [])
      @name = name
      @days = days
      @score = score
      @best_before = best_before
      @roles = roles
    end

    def plannable?
      roles.all? { |r| r.contributor }
    end

    def unplan!
      roles.each { |r| r.contributor = nil }
    end

    def end_time
      start_time&.+ days
    end

    def level_up!
      roles.each do |role|
        skill = role.contributor.skills.find { |s| s.name == role.name }

        if skill.level == role.level
          puts "Levelling up #{role.contributor.name}: #{skill.name} #{skill.level} => #{skill.level + 1}"
          skill.level += 1
        end
      end
    end

    def ==(other)
      name == other.name
    end
  end
end
