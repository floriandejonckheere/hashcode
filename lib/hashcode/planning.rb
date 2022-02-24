# frozen_string_literal: true

module HashCode
  class Planning
    attr_reader :contributors, :projects

    def initialize(contributors, projects)
      @contributors = contributors
      @projects = projects
    end

    def solve
      projects.sort_by!(&:score)

      time = 0

      available_contributors = contributors

      available_projects = projects
      active_projects = []

      while available_projects.any? do
        puts "Contributors: #{available_contributors.map(&:name)}, projects: #{available_projects.map(&:name)}"

        # Level up
        active_projects.select { |p| p.end_time == time }.each do |project|
          available_contributors += project.roles.map(&:contributor)
          project.level_up!
        end

        planned_contributors = []

        # Find available contributors
        available_contributors.each do |contributor|
          puts "Finding role for #{contributor.name}"

          role = contributor.eligible(available_projects)

          if role
            puts "Found role #{role.name} #{role.level} for #{contributor.name} in project #{role.project.name}"

            role.contributor = contributor
            planned_contributors << contributor
          end
        end

        available_contributors -= planned_contributors

        plannable_projects, unplannable_projects = available_projects.partition(&:plannable?)
        puts "Plannable: #{plannable_projects.map(&:name)}, unplannable: #{unplannable_projects.map(&:name)}"


        abort("Oh no!") if plannable_projects.empty?

        # Plan projects
        available_projects -= plannable_projects
        active_projects += plannable_projects
        plannable_projects.each { |p| p.start_time = time }

        # Unplan projects
        unplannable_projects.each do |project|
          project.roles.select { |r| r.contributor }.each do |role|
            available_contributors << role.contributor
            role.contributor = nil
          end
        end

        time += active_projects.min { |p| p.end_time }.days
      end

      Solution.new(active_projects)
    end
  end
end
