require 'spec_helper'

describe Processors::SimpleTokenizer do
  it 'should split text by spaces' do
    input = 'the wonderful thing'
    expect(described_class.call(input)).to include 'the'
    expect(described_class.call(input)).to include 'wonderful'
    expect(described_class.call(input)).to include 'thing'
  end
  it 'should remove punctuation' do
    input = 'This., -/ is #! an $ % ^ & * example ;: {} of a = -_ string with `~)() punctuation'
    expect(described_class.call(input)).to eql %w(this is an example of a string with punctuation)
  end
  it 'should convert to lowercase' do
    input = 'THIS sentence HAS both UPPERCASE aNd lowercase'
    expect(described_class.call(input)).to eql %w(this sentence has both uppercase and lowercase)
  end
end
