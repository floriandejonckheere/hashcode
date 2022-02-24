# frozen_string_literal: true

module HashCode
  class Planning
    attr_reader :projects

    def initialize(projects)
      @projects = projects
    end
  end
end