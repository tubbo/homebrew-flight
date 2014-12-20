require 'flight/brewfile/dsl'
require 'flight/brewfile/lockfile'

require 'flight/package'
require 'flight/tap'

require 'json'

module Flight
  # Parses a Brewfile, responsible for instantiating collections of
  # Package objects.
  class Brewfile
    include DSL

    attr_reader :filename

    attr_reader :lockfile

    attr_accessor :packages

    attr_accessor :taps

    DEFAULT_SOURCE = 'homebrew/homebrew'

    attr_accessor :source_repository

    def initialize(filename='./Brewfile')
      @filename = File.expand_path(filename)
      @lockfile = Lockfile.new filename, existing_lockfile_data
      @packages = Package::Collection.new
      @taps = Tap::Collection.new
      @source_repository = DEFAULT_SOURCE
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
      lockfile.taps != taps.to_json || lockfile.packages != packages.to_json
    end

    def default_source?
      source_repository == DEFAULT_SOURCE
    end

    def lock
      update_lockfile and write_lockfile
    end

    private
    def update_lockfile
      lockfile.taps = tap_attributes
      lockfile.packages = package_attributes
      lockfile.taps.any? && lockfile.packages.any?
    end

    def write_lockfile
      File.write lockfile.path, lockfile.to_json
      lockfile.exist?
    end

    private
    def contents
      @contents ||= File.read filename
    rescue Errno::ENOENT
      raise "You must have a Brewfile in this dir to proceed."
    end

    def lockfile_contents
      JSON.parse File.read("#{filename}.lock")
    rescue
      nil
    end
  end
end
