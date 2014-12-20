require 'flight/package/collection'
require 'flight/package/options'

module Flight
  # Represents a single Package in the Brewfile.
  class Package
    # Parameters passed in as options when instantiated.
    attr_reader :params

    # The name of this package
    attr_accessor :name

    # The version to install
    attr_writer :version

    # Any build options to be passed in
    attr_writer :options

    # Instantiate the object and assign any attributes.
    def initialize(arguments={})
      @params = arguments
      @options = Options.new params[:options]

      params.each do |key, value|
        setter = "#{key}="
        send setter, value if respond_to? setter
      end
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

    def version
      if @version.empty?
        current_version
      else
        @version.first
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

    private
    def info
      @info ||= `brew info #{name}`
    end
  end
end
