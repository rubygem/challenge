require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')

class AllTheTests < Test::Unit::TestCase

	# 3. `5` - The "settlement period". You can ignore this field.
	# 4. `20110712010000` - Start date/time.
	# 5. `475.000` - Start output level, in MW ([Megawatts](http://en.wikipedia.org/wiki/Megawatt#Megawatt))
	# 6. `20110712011800` - Finish date/time.
	# 7. `300.000` - Finish output level.

	# In this directory, you will find a file called `tib_messages_FPN.2011-07-12.gz`. When you extract it, you'll get a CSV file. The file contains raw data about UK electricity generation on 12th July 2011. A single row looks something like this:
	# 	```
	# 	PN,T_RATS-1,5,20110712010000,475.000,20110712011800,300.000
	# 	```
	def test_read_first_line
		first_line = CSVFile.new.lines[0] 
		assert_equal "PN,T_ABTH7,5,20110712010000,485.000,20110712013000,485.000", first_line
	end

	# 1. `PN` - Physical Notification. All rows are `PN` rows so you can ignore this field.
	def test_read_physical_notification
		line = CSVFile.new.lines[0]
		generated_electricity = ElectricityGeneration.new(line:line)
		assert_equal "PN", generated_electricity.physical_notification
	end

	# 2. `T_RATS-1` - Unit id. A unique identifier for the generation unit (power station boiler, wind turbine, etc).
	def test_read_unit_id
		line = CSVFile.new.lines[0]
		generated_electricity = ElectricityGeneration.new(line:line)
		unit_id = generated_electricity.unit_id
		assert_equal "T_ABTH7", unit_id
	end

	def csv line:line
		csv = line.split(',')
	end
end

class ElectricityGeneration
	def initialize line:line
		@csv = line.split(',')
	end

	def physical_notification
		@csv[0]
	end

	def unit_id
		@csv[1]
	end

end