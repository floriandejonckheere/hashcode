# frozen_string_literal: true

module HashCode
  class Planning
    attr_reader :projects

    def initialize(contributors, projects)
      @contributors = contributors
      @projects = projects
    end

    def solve!
      raise NotImplementedError
    end
  end
end
