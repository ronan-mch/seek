$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'seek'
require 'byebug'
SimpleDoc = Struct.new(:title, :id)
