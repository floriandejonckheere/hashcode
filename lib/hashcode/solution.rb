# frozen_string_literal: true

module HashCode
  class Solution
    attr_reader :assignments

    def initialize(assignments = [])
      @assignments = assignments
    end
  end
end
