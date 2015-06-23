require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')

class ReadingFileTests < Test::Unit::TestCase
	# In this directory, you will find a file called `tib_messages_FPN.2011-07-12.gz`. When you extract it, you'll get a CSV file. The file contains raw data about UK electricity generation on 12th July 2011. A single row looks something like this:
	# 	```
	# 	PN,T_RATS-1,5,20110712010000,475.000,20110712011800,300.000
	# 	```

	def test_read_first_line
		first_line = CSVFile.new.lines[0] 
		assert_equal "PN,T_ABTH7,5,20110712010000,485.000,20110712013000,485.000", first_line
	end
end