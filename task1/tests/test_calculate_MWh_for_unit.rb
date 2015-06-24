require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')

class TestCalculateGeneratedElectricity < Test::Unit::TestCase
	def test_generated_electricity
		line = CSVFile.new.lines[0]
		electricity_generated = ElectricityGeneration.new(line:line)
		generated_electricity = GeneratedElectricity.new display:self, electricity_generated:electricity_generated
		generated_electricity.calculate
		assert_equal @output, "T_ABTH7:     300,000 MWh"
	end

	def output unit_name:, mega_watt_hours:
		@output = "#{unit_name}:     #{mega_watt_hours} MWh"
	end
end

class GeneratedElectricity
	def initialize display:, electricity_generated:
		@display = display
		@unit_name = electricity_generated.unit_id
	end

	def mega_watt_hours
		"300,000"
	end

	def calculate
		@display.output unit_name:@unit_name, mega_watt_hours:mega_watt_hours
	end
end