require 'bundler/setup'
require 'test/unit'

class AllTheTests < Test::Unit::TestCase
	def test_something
		csv_file = File.expand_path('../../data/tib_messages_FPN.2011-07-12', __FILE__)
		csv = File.read(csv_file) 
		assert_equal 0, 0
	end
end
