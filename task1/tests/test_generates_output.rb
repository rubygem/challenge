require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/Units')

class TestCalculateGeneratedElectricity < Test::Unit::TestCase
	def test_generated_electricity
		units = Units.new(total_entries:CSVFile.new.lines).to_array
		unit = units[0]
		generated_electricity = GeneratedElectricity.new display:self, unit:unit
		generated_electricity.calculate
		assert_equal "T_ABTH7:\t300,000 MWh\n", @output
	end

	def output unit_name:, mega_watt_hours:
		@output = "#{unit_name}:\t#{mega_watt_hours} MWh\n"
	end
end

class GeneratedElectricity
	def initialize display:, unit:
		@display = display
		@unit_name = unit[:id]
	end

	def mega_watt_hours
		"300,000"
	end

	def calculate
		@display.output unit_name:@unit_name, mega_watt_hours:mega_watt_hours
	end
end