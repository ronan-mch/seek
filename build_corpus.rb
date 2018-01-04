require 'lib/seek'
paths = Pathname.new('corpus/shakespeare/').children.select {|p| p.basename.to_s.include? 'txt' }
index = Seek::Indexer.new
index.build(files: paths)

