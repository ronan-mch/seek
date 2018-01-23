require 'spec_helper'

describe IndexConfigHelper do
  let(:test_class) { Class.new { extend IndexConfigHelper } }
  describe 'configure_index' do
    it 'should be added to class' do
      expect(test_class).to respond_to :configure_index
    end
  end
  describe 'index_config' do
    it 'should return an IndexConfiguration object' do
      expect(test_class.index_config).to be_an IndexConfiguration
    end
  end
  describe 'write' do
    it 'should be added to class' do
      expect(test_class).to respond_to :write
    end
  end
  describe 'configuration workflow' do
    it 'should allow us to add and retrieve a config' do
      test_class.configure_index do |config|
        config.add_field(name: :title)
        config
      end
      expect(test_class.index_config.field_names).to include :title
    end
  end
end
