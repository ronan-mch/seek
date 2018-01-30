require 'spec_helper'

describe FieldIndex do
  let(:field_config) { IndexConfiguration::FieldConfiguration.new(args) }
  let(:doc) { SimpleDoc.new(val, 128) }
  let(:args) { { name: :title, accessor: nil, processor_chain: [] } }
  let(:val) { 'the wonderful thing about tiggers' }
  let(:field_index) { described_class.new(field_config) }
  describe '#initialize' do
    it 'is initialized with a field config' do
      expect(field_index.config).to eql field_config
    end
  end

  describe '#find' do
    it 'finds the occurences of a term' do
      field_index.write_terms(doc)
      expect(field_index.find('the wonderful thing about tiggers')).to include doc.id
    end
  end
end
