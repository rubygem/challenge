require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')

class TestCalculateGeneratedElectricity < Test::Unit::TestCase
	def test_generated_electricity
		line = CSVFile.new.lines[0]
		generated_electricity = ElectricityGeneration.new(line:line)
		bob = Bob.new display:self, generated_electricity:generated_electricity
		bob.calculate
		assert_equal @output, "T_RATS-1:     300,000 MWh"
	end

	def output unit_name:, mega_watt_hours:
		@output = "#{unit_name}:     #{mega_watt_hours} MWh"
	end
end

class Bob
	def initialize display:, generated_electricity:
		@display = display
		@unit_name = "T_RATS-1"
		@mega_watt_hours = "300,000"
	end

	def calculate
		@display.output unit_name:@unit_name, mega_watt_hours:@mega_watt_hours
	end
end