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

      # Attributes for the lockfile include Flight metadata, taps and
      # packages extracted as attributes for later re-use.
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

      # Parse attributes to JSON.
      def to_json
        attributes.to_json
      end

      # This Lockfile is valid if the JSON parse succeeds.
      def valid?
        !!to_json
      rescue JSON::ParserError
        false
      end

      def save
        valid? and write and exist?
      end

      def update_attributes(with_new_attributes={})
        @attributes = self.attributes.merge(with_new_attributes)
        save
      end

      private
      def write
        File.write path, to_json
      end
    end
  end
end
