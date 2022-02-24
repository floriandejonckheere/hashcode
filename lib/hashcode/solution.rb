module HashCode
  class Solution
    attr_reader :projects

    def initialize(projects)
      @projects = projects
    end

    def to_s
      string = "#{projects.count}\n"

      projects.each do |project|
        string << "#{project.name}\n"

        string << "#{project.roles.map { |r| r.contributor.name }.join(" ")}\n"
      end

      string
    end
  end
end
