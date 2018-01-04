module Seek
  module Input
    class FileReader
      include ReaderFunctions
      attr_reader :content, :id

      def initialize(file_path)
        file = File.open(file_path)
        @content = file.read
        @id = file_path
      end
    end
  end
end

