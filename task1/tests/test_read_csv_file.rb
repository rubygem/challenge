require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')

class ReadingFileTests < Test::Unit::TestCase
	def test_read_first_line
		first_line = CSVFile.new.lines[0] 
		assert_equal "PN,T_ABTH7,5,20110712010000,485.000,20110712013000,485.000", first_line
	end
end