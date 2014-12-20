module Flight
  # Represents a tap designated by the `tap` directive in Brewfile. This
  # is a repo we should be pulling formulae from.
  class Tap
    attr_reader :name

    def initialize(with_name)
      @name = with_name
    end

    def installed?
      `brew tap`.include? name
    end

    class Collection
      attr_reader :all

      def initialize(with_taps=[])
        @all = with_taps
      end

      def unknown
        all.reject do |tap|
          known.include? tap.name
        end
      end

      def known
        `brew tap`.split("\n").map { |name| Tap.new(name) }
      end

      def <<(new_tap)
        @all << new_tap
      end
    end
  end
end
