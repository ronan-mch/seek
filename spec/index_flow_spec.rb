require 'spec_helper'

class TestIndex
  include IndexConfigHelper
  configure_index do |config|
    config.add_field(name: :title, accessor: :title, processor_chain: [])
    config
  end
end
describe 'basic flow' do
  # first we create an indexer class
  # that includes the IndexConfigHelper
  # then, we configure it by adding some fields
  # finally, we index some documents
  let(:test_index) { TestIndex.new }
  let(:doc_struct) { SimpleDoc = Struct.new(:title) }
  let(:basic_doc) { SimpleDoc.new('the wonderful thing about tiggers') }
  it 'should allow us to write some documents then find them' do
    test_index.write(basic_doc)
    expect(test_index.find(title: 'tiggers').size).to eq 1
  end
end
