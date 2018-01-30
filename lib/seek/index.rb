class Index
  attr_reader :config

  def initialize(index_config)
    @config = index_config
    @field_indices = {}
    @config.fields.each do |f|
      @field_indices[f.name] = FieldIndex.new(f)
    end
  end

  def write(doc)
    raise InvalidDocumentIdError unless valid_id?(doc)
    config.fields.each do |f|
      @field_indices[f.name].write_terms(doc)
    end
  end

  def find(query_hash)
    ids = []
    query_hash.each do |key, val|
      ids << @field_indices[key].find(val).to_a
    end
    # Array intersection to ensure all terms are matched
    ids.reduce {|common, current| current & common }
  end

  private
  def valid_id?(doc)
    doc.respond_to?(:id) && doc.id.is_a?(Integer)
  end
end
