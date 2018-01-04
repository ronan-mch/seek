module Seek
  module Input
    class StringReader
      include ReaderFunctions
      def initialize(input)
        @content = input
      end
    end
  end
end
