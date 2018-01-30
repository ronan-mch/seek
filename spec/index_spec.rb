require 'spec_helper'

describe Index do
  let(:index_config) { IndexConfiguration.new }
  let(:index) { described_class.new(index_config) }
  describe '#initialize' do
    it 'is initialized with an index config' do
      expect(index.config).to be_an IndexConfiguration
    end
  end
  describe 'write' do
    SimpleDoc = Struct.new(:title, :id)
    describe '#write' do
      let(:val) { 'tiggers' }
      let(:basic_doc) { SimpleDoc.new(val, 128) }
      it 'saves the document terms to the index based on the field config' do
        index_config.add_field(name: :title)
        index.write(basic_doc)
        expect(index.find(title: 'tiggers')).to include basic_doc.id
      end
      let(:no_id_doc) { SimpleDoc.new(val) }
      it 'raises an error if the doc does not have an id' do
        pending
        subject.add_field(name: :title)
        expect {
          subject.write(no_id_doc)
        }.to raise_error(IndexConfiguration::InvalidDocumentIdError)
      end
    end
  end
end
