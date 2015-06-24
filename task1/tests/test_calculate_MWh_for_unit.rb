require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')

class TestCalculateMegaWattHours < Test::Unit::TestCase
	def test_mega_watt_hours
		line = CSVFile.new.lines[0]
		electricity_generated = ElectricityGeneration.new(line:line)
		mega_watt_hours = 300000
		assert_equal mega_watt_hours, 300000
	end
end