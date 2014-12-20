module Flight
  class Package
    # Represents the entire Brewfile.
    class Collection
      include Enumerable

      attr_accessor :all

      def initialize(with_packages=[])
        @all = with_packages
      end

      def each
        all.each { |package| yield package }
      end

      # Filter out packages which are installed.
      def installed
        all.select(&:installed?)
      end

      # Filter out packages which are installed, but according to
      # Homebrew are out of date.
      def outdated
        all.select(&:up_to_date?)
      end

      def <<(new_pkg)
        @all << new_pkg
      end

    end
  end
end
