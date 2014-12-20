require 'flight/brewfile/dsl'
require 'flight/package'
require 'flight/tap'
require 'json'

module Flight
  # Parses a Brewfile, responsible for instantiating collections of
  # Package objects.
  class Brewfile
    include DSL

    attr_reader :filename

    attr_accessor :packages

    attr_accessor :taps

    def initialize(filename='./Brewfile')
      @filename = File.expand_path(filename)
      @packages = Package::Collection.new
      @taps = Tap::Collection.new
    end

    def self.parse!
      file = new
      file.parse
      file.lock if file.changed?
      file
    end

    def parse
      instance_eval contents
    end

    def changed?
      true
    end

    def lock
      File.write filename, {
        flight: {
          version: Flight::VERSION,
          ruby_version: RUBY_VERSION,
          brew_version: `brew --version`,
          last_flown: Time.now.to_i
        },
        taps: taps.all,
        packages: packages.all
      }.to_json
    end

    private
    def contents
      @contents ||= File.read filename
    rescue Errno::ENOENT
      raise "You must have a Brewfile in this dir to proceed."
    end
  end
end
