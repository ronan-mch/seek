require 'spec_helper'
describe Seek::Indexer do
  subject { described_class.new }
  describe 'add' do
    let(:document) { Seek::Indexer::Document.new('xxy', 'I know where he is') }
    it 'should add a document' do
      subject.add(document)
      expect(subject.dictionary['know']).to include 'xxy'
    end
  end
end
