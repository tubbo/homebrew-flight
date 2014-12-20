require 'json'
require 'flight/version'

module Flight
  class Brewfile
    class Lockfile
      attr_accessor :taps

      attr_accessor :packages

      attr_reader :path

      def initialize(from_filename, and_json=nil)
        @path = "#{from_filename}.lock"
        @attributes = and_json
      end

      def exist?
        File.exist? path
      end

      def attributes
        @attributes ||= {
          flight: {
            version: Flight::VERSION,
            ruby_version: RUBY_VERSION,
            brew_version: `brew --version`,
            locked_at: Time.now.to_i,
            debug: (Flight.debug?) ? 'on' : 'off'
          },
          taps: taps,
          packages: packages
        }
      end

      def to_json
        attributes.to_json
      end
    end
  end
end
