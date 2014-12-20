require 'flight/package/collection'
require 'flight/package/options'
require 'flight/package/version'

module Flight
  # Represents a single Package in the Brewfile.
  class Package
    # Parameters passed in as options when instantiated.
    attr_reader :params

    # The name of this package
    attr_accessor :name

    # Any build options to be passed in
    attr_reader :options

    # Instantiate the object and assign any attributes.
    def initialize(arguments={})
      @params = arguments
      @options = Options.new @params.delete(:options)
      @version = Version.new @params.delete(:version)

      params.each do |key, value|
        setter = "#{key}="
        send setter, value if respond_to? setter
      end
    end

    def version=(new_version_string)
      @version.string = new_version_string
    end

    def to_s
      "#{name} at v#{version}"
    end

    # Render relevant attributes as a Hash.
    def attributes
      {
        name: name,
        version: version,
        options: options.to_h
      }
    end

    # The version of this package as defined by Homebrew.
    def current_version
      if info =~ /#{name}: stable (?<version>.*)(\(|,)/
        $1.strip
      end
    end

    def has_version?
      @version != '>= 0'
    end

    def requested_version
      @version
    end

    def version
      if has_version?
        requested_version
      else
        current_version
      end
    end

    # Check if this package is installed with Homebrew. Actually, it
    # checks if this package is not NOT installed with Homebrew. :)
    def installed?
      info !~ /Not Installed/
    end

    # Checks if this package is up-to-date by comparing the stored
    # version with the latest version from Homebrew's info command.
    def up_to_date?
      info.split("\n").first.include? version
    end

    def outdated?
      (not up_to_date?)
    end

    private
    def info
      @info ||= `brew info #{name}`
    end
  end
end
