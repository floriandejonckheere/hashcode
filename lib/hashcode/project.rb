# frozen_string_literal: true

module HashCode
  class Project
    attr_reader :name, :days, :score, :best_before, :roles

    def initialize(name, days, score, best_before, roles)
      @name = name
      @days = days
      @score = score
      @best_before = best_before
      @roles = roles
    end
  end
end
