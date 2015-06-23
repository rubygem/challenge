require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')

class AllTheTests < Test::Unit::TestCase

	# 4. `20110712010000` - Start date/time.
	# 5. `475.000` - Start output level, in MW ([Megawatts](http://en.wikipedia.org/wiki/Megawatt#Megawatt))
	# 6. `20110712011800` - Finish date/time.
	# 7. `300.000` - Finish output level.

	# In this directory, you will find a file called `tib_messages_FPN.2011-07-12.gz`. When you extract it, you'll get a CSV file. The file contains raw data about UK electricity generation on 12th July 2011. A single row looks something like this:
	# 	```
	# 	PN,T_RATS-1,5,20110712010000,475.000,20110712011800,300.000
	# 	```

	def generated_electricity
		line = CSVFile.new.lines[0]
		ElectricityGeneration.new(line:line)
	end

	def test_read_physical_notification
		assert_equal "PN", generated_electricity.physical_notification
	end

	def test_read_unit_id
		assert_equal "T_ABTH7", generated_electricity.unit_id
	end

	# def test_read_settlement_period
	# 	generated_electricity = ElectricityGeneration.new(line:line)
	# 	assert_equal "T_ABTH7", generated_electricity.settlement_period
	# end
end

class ElectricityGeneration
	def initialize line:line
		@csv = line.split(',')
	end

	# 1. `PN` - Physical Notification. All rows are `PN` rows so you can ignore this field.
	def physical_notification
		@csv[0]
	end

	# 2. `T_RATS-1` - Unit id. A unique identifier for the generation unit (power station boiler, wind turbine, etc).
	def unit_id
		@csv[1]
	end

	# 3. `5` - The "settlement period". You can ignore this field.
end