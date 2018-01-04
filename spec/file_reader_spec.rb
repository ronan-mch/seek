require 'spec_helper'

describe Seek::Input::FileReader do
  let(:test_file) { 'tmp/test_file.txt' }
  subject { described_class.new(test_file) }
  before { File.open(test_file, 'wb') {|f| f.puts "ONE TWO THREE\n" } }
  after { File.delete(test_file) }
  describe 'tokens' do
    it 'should return the tokens from the test file' do
      expect(subject.tokens).to eql %w(one two three)
    end
  end
  describe 'id' do
    it 'returns the path to the file' do
      expect(subject.id).to eql test_file
    end
  end
end
