module Flight
  class Package
    # Stores command-line options for a Package as a Hash, and outputs
    # said options to a String suitable for tacking onto the end of a
    # `brew install` run.
    class Options
      def initialize(from_hash={})
        @hash = from_hash
      end

      # Convert the hash of build options into a string of command-line
      # arguments.
      def to_s
        @hash.map { |key, value|
          option = key.to_s.gsub(/_/, '-')
          if value.is_a? Boolean
            value ? "--#{option}" : "--no-#{option}"
          else
            "--#{option}=#{value}"
          end
        }.join("\s")
      end

      # Output options as a Hash.
      def to_h
        @hash
      end
    end
  end
end
