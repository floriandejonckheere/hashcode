# frozen_string_literal: true

module HashCode
  class Application
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def start
      contributors, projects = parse!

      planning = Planning.new(contributors, projects)

      solution = planning.solve

      File.write("solution.txt", solution.to_s) if solution
    end

    private

    def parse!
      number_of_contributors, number_of_projects = iterator.next.split(" ").map(&:to_i)

      contributors = number_of_contributors.times.map do |i|
        name, number_of_skills = iterator.next.split(" ")

        number_of_skills = number_of_skills.to_i

        contributor = Contributor.new(name)

        skills = number_of_skills.times.map do |j|
          skill_name, level = iterator.next.split(" ")

          Skill.new(skill_name, level.to_i, contributor)
        end

        contributor.skills = skills

        contributor
      end

      projects = number_of_projects.times.map do |i|
        name, days, score, best_before, number_of_roles = iterator.next.split(" ")

        project = Project.new(name, days.to_i, score.to_i, best_before.to_i)

        roles = number_of_roles.to_i.times.map do |j|
          role_name, level = iterator.next.split(" ")

          Role.new(role_name, level.to_i, project)
        end

        project.roles = roles

        project
      end

      return [contributors, projects]
    end

    def iterator
      @iterator ||= File
        .readlines(filename)
        .map(&:chomp)
        .each
    end
  end
end
