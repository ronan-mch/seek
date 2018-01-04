require 'spec_helper'
describe Seek::Input::ReaderBuilder do
  describe 'get_reader' do
    subject { described_class.get_reader(input) }
    context 'when passed a filepath' do
      let(:input) { 'tmp/test' }
      before { File.new('tmp/test', 'wb') }
      after { File.delete('tmp/test') }
      it { should be_an Seek::Input::FileReader }
    end
    context 'when passed a string' do
      let(:input) { 'A string input' }
      it { should be_an Seek::Input::StringReader }
    end
  end
end
