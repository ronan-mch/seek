module Processors
  class SimpleTokenizer
    def self.call(input_string)
      input_string
        .gsub(/[.,\/#!$%\^&\*;:{}=\-_`~()]/, ' ')
        .downcase
        .split(/\s+/)
    end
  end
end
