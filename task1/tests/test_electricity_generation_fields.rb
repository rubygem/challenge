require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')


class AllTheTests < Test::Unit::TestCase
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

	def test_read_settlement_period
		assert_equal "5", generated_electricity.settlement_period
	end

	def test_read_started
		assert_equal "20110712010000", generated_electricity.started
	end

	def test_read_finished
		assert_equal "20110712013000", generated_electricity.finished
	end

	def test_read_start_output_level
		assert_equal "485.000", generated_electricity.start_output_level
	end

	def test_read_finished_output_level
		assert_equal "485.000", generated_electricity.finished_output_level
	end
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
	def settlement_period
		@csv[2]
	end
	
	# 4. `20110712010000` - Start date/time.
	def started
		@csv[3]
	end
	
	# 5. `475.000` - Start output level, in MW ([Megawatts](http://en.wikipedia.org/wiki/Megawatt#Megawatt))
	def start_output_level
		@csv[4]
	end
	
	# 6. `20110712011800` - Finish date/time.
	def finished
		@csv[5]
	end

	# 7. `300.000` - Finish output level.
	def finished_output_level
		@csv[6]
	end
end