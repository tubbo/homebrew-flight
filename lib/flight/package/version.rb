module Flight
  class Package
    class Version
      attr_accessor :string

      def initialize(with_string)
        @string = with_string
      end

      def to_s
        resolve string
      end

      private
      def resolve(string)
        string
      end
    end
  end
end
