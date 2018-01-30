require 'spec_helper'

describe IndexConfiguration do
  subject { described_class.new }
  describe '#add_field' do
    it { should respond_to :add_field }
    it 'should add field configuration' do
      subject.add_field(name: :title, accessor: :title, processor_chain: [])
      expect(subject.field_names).to include :title
    end
  end
  describe '#fields' do
    it { should respond_to :fields }
    it 'should be enumerable' do
      expect(subject.fields).to be_an Enumerable
    end
  end
end
describe IndexConfiguration::FieldConfiguration do
  let(:field_config) { described_class.new(args) }
  let(:basic_doc) { SimpleDoc.new(val) }
  describe 'values_for' do
    subject { field_config.values_for(basic_doc) }
    context 'when accessor is nil' do
      let(:args) { { name: :title, accessor: nil, processor_chain: [] } }
      let(:val) { 'the wonderful thing about tiggers' }
      it 'should use the name attr as the accessor' do
        expect(subject).to eql ['the wonderful thing about tiggers']
      end
    end
    context 'when accessor is lambda' do
      let(:args) { { name: :title, accessor: lambda {|d| d.title.first }, processor_chain: [] } }
      let(:val) { %w(first second) }
      it 'calls the lambda with the doc' do
        expect(subject).to include 'first'
      end
    end
    context 'when accessor is class' do
      class DummyClass
        def self.call(doc)
          'dummy: ' + doc.title
        end
      end
      let(:args) { { name: :title, accessor: DummyClass, processor_chain: [] }}
      let(:val) { 'bla' }
      it 'should call the object passed with the doc' do
        expect(subject.first).to include 'dummy'
      end
    end
    describe 'with processor chain' do
      class DummyProcessor
        def self.call(val)
          ['fakeval'] + Array(val)
        end
      end
      let(:args) { { name: :title, accessor: nil, processor_chain: [ DummyProcessor ] } }
      let(:val) { 'the wonderful thing about tiggers' }
      it 'should call the tokenizer on the values' do
        expect(subject).to include 'fakeval'
        expect(subject).to include val
      end
    end
  end
end
