# frozen_string_literal: true

module HashCode
  class Application
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def start
      n = 0

      number_of_contributors, number_of_projects = lines.first.split(" ").map(&:to_i)

      contributors = number_of_contributors.times.map do |i|
        name, number_of_skills = lines[i + 1].split(" ")

        number_of_skills = number_of_skills.to_i

        contributor = Contributor.new(name)

        skills = number_of_skills.times.map do |j|
          skill_name, level = lines[i + 1 + j].split(" ")

          Skill.new(skill_name, level.to_i, contributor)
        end

        n += number_of_skills + 1

        contributor.skills = skills

        contributor
      end

      projects = number_of_projects.times.map do |i|
        name, days, score, best_before, number_of_roles = lines[n].split(" ")

        project = Project.new(name, days.to_i, score.to_i, best_before.to_i)

        roles = number_of_roles.to_i.times.map do |j|
          role_name, level = lines[i + 1 + j].split(" ")

          Role.new(role_name, level.to_i, project)
        end

        project.roles = roles

        project
      end
    end

    def lines
      @lines ||= File
        .readlines(filename)
        .map(&:chomp)
    end
  end
end
