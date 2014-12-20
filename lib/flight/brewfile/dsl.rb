require 'flight/tap'
require 'flight/package'

module Flight
  class Brewfile
    # The various commands you can use in a Brewfile.
    module DSL
      # Change the source of this Brewfile. Defaults to
      # 'homebrew/homebrew', but you can supply your own fork here if
      # necessary.
      def source(path)
        self.source_repository = "https://github.com/#{path}.git"
      end

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
          version: version.join("\s"),
          options: options
        )
      end
    end
  end
end
