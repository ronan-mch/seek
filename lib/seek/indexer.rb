module Seek
  class Indexer
    Document = Struct.new(:id, :content) do
      def tokens
        content.downcase.split(/\s+/)
      end
    end
    attr_accessor :dictionary
    def initialize
      @dictionary = {}
    end

    def add(doc)
      doc.tokens.each {|t| add_term(t, doc.id) }
      true
    end

    def add_term(term, doc)
      @dictionary[term] = (@dictionary[term] || []) << doc
    end
  end
end
