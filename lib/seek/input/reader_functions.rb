# To be included in all input types
# Adds common parsing functionality
# @content is presumed to be a string
# representing the content of the document.
module Seek
  module Input
    module ReaderFunctions
      def tokens
        @tokens ||= @content.downcase.split(/\s+/)
      end
    end
  end
end
