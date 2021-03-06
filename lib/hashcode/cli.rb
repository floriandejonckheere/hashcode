# frozen_string_literal: true

require "optparse"
require "English"

module HashCode
  class CLI
    attr_reader :parser, :args, :command_args

    def initialize(args)
      @parser = OptionParser.new("#{File.basename($PROGRAM_NAME)} [global options] command") do |o|
        o.on("Global options:")
        o.on("-f", "--filename=FILENAME", "Input filename")
        o.on("-v", "--verbose", "Turn on verbose logging")
        o.on("-D", "--debug", "Turn on debug logging")
        o.on("-h", "--help", "Display this message") { usage }
      end

      @args = args
      @command_args = []

      parse!
    end

    def parse!
      # Parse command line arguments (in order) and extract non-option arguments
      # (unrecognized option values). Raise for invalid option arguments (unrecognized
      # option keys). "--foo FOO --bar BAR" will result in "--foo" and "FOO" being parsed
      # correctly, "--bar" and "BAR" will be extracted.
      parser.order!(args, into: HashCode.options) { |value| command_args << value }
    rescue OptionParser::InvalidOption => e
      @command_args += e.args
      retry
    end

    def start
      Application
        .new(HashCode.options.filename)
        .start
    rescue UsageError => e
      # Don't print tail if no message was passed
      return usage if e.message == e.class.name

      usage(tail: "#{File.basename($PROGRAM_NAME)}: #{e.message}")
    rescue Error => e
      HashCode.logger.fatal e.message
    end

    private

    def usage(code: 1, tail: nil)
      HashCode.logger.info parser.to_s
      HashCode.logger.info tail if tail

      raise ExitError, code
    end
  end
end
