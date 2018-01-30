class FieldIndex
  attr_reader :config

  def initialize(field_config)
    @config = field_config
    @dictionary = {}
  end


  def write_terms(doc)
    @config.values_for(doc).each do |t|
      tl = find(t) << doc.id
      @dictionary[t] = tl
    end
  end

  def find(term)
    @dictionary.fetch(term, SortedSet.new)
  end
end
