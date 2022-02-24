# frozen_string_literal: true

module HashCode
  class Application
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def start
      number_of_contributors, number_of_projects = lines.first.split(" ").map(&:to_i)

      number_of_contributors.each do |i|
        name, number_of_skills = lines[i + 1].split(" ")

        number_of_skills.to_i.each do |j|

        end
      end
    end

    def lines
      @lines ||= File
        .readlines(filename)
        .map(&:chomp)
    end
  end
end
