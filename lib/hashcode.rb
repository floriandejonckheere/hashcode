# frozen_string_literal: true

require "active_support/all"
require "zeitwerk"
require "debug"

require "byebug" if ENV["ENV"] == "development"

module HashCode
  class << self
    attr_reader :loader

    def root
      @root ||= Pathname.new(File.expand_path(File.join("..", ".."), __FILE__))
    end

    def options
      @options ||= Options.new
    end

    def logger
      @logger ||= Logger.new
    end

    def setup
      @loader = Zeitwerk::Loader.for_gem

      # Register inflections
      instance_eval(File.read(root.join("config/inflections.rb")))

      # Set up code loader
      loader.enable_reloading
      loader.setup
      loader.eager_load
    end
  end
end

if ENV["ENV"] == "development"
  def reload!
    HashCode.loader.reload
  end
end

HashCode.setup
