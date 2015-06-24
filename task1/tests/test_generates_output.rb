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