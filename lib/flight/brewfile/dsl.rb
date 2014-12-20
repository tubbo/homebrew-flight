require 'flight/tap'
require 'flight/package'

module Flight
  class Brewfile
    # The various commands you can use in a Brewfile.
    module DSL
      # Install a tap source.
      def tap(repo)
        self.taps << Tap.new(name: repo)
      end

      # Install a package.
      def brew(name, *args)
        options = args.last.is_a?(Hash) ? args.pop.dup : {}
        version = args || [">= 0"]

        self.packages << Package.new(
          name: name,
          version: version,
          options: options
        )
      end
    end
  end
end
