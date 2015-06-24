require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')

class TestCalculateGeneratedElectricity < Test::Unit::TestCase
	def test_generated_electricity
		line = CSVFile.new.lines[0]
		ElectricityGeneration.new(line:line)
		unit_name = "T_RATS-1"
		mega_watt_hours = "300,000"
		output = "#{unit_name}:     #{mega_watt_hours} MWh"
		assert_equal output, "T_RATS-1:     300,000 MWh"
	end
end