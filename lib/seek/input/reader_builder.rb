module Seek
  module Input
    class ReaderBuilder

      def self.get_reader(input)
        if File.exist?(input)
          FileReader.new(input)
        elsif input.is_a? String
          StringReader.new(input)
        end
      end
    end
  end
end
