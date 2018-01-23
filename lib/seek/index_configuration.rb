class IndexConfiguration
  class InvalidDocumentIdError < StandardError; end
  class FieldConfiguration
    attr_reader :name, :accessor, :processor_chain
    def initialize(name:, accessor:, processor_chain:)
      @name = name
      @accessor = accessor
      @processor_chain = processor_chain
    end

    def values_for(doc)
      val =
        if accessor.nil?
          doc.send(name)
        elsif accessor.respond_to?(:call)
          accessor.call(doc)
        end
      process(val)
    end

    def process(v)
      @processor_chain.reduce(Array(v)) {|acc, p| p.call(acc) }
    end
  end
  attr_reader :fields, :indexed_fields

  def initialize
    @fields = []
    @indexed_fields = {}
  end

  def add_field(name:, accessor: nil, processor_chain: [])
    sym_name = name.to_sym
    @fields << FieldConfiguration.new(name: name, accessor: accessor, processor_chain: processor_chain)
    unless @indexed_fields.has_key?(sym_name)
      @indexed_fields[sym_name] = {}
    end
    @fields
  end

  def field_names
    @fields.map(&:name)
  end

  def write(doc)
    raise InvalidDocumentIdError unless valid_id?(doc)
    @fields.each do |f|
      vals = f.values_for(doc)
      vals.each do |v|
        @indexed_fields[f.name][v] = (@indexed_fields[f.name][v] || []) << doc.id
      end
    end
  end

  private
  def valid_id?(doc)
    doc.respond_to?(:id) && doc.id.is_a?(Integer)
  end
end
