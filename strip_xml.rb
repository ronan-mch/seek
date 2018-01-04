require 'nokogiri'
require 'pathname'

text_paths = Pathname.new('corpus/shakespeare').children.select {|p| p.basename.to_s.include? 'xml' }

text_paths.each do |p|
  name = p.basename.to_s.sub('.xml', '')
  content = File.open(p) {|f| f.read }
  text = Nokogiri::XML(content).text
  File.open("corpus/shakespeare/#{name}.txt", 'wb') {|f| f.puts text }
end


