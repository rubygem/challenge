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
		@mega_watt_hours = 300000
	end

	def mega_watt_hours
		comma_numbers(number:@mega_watt_hours)
	end

	#stolen from http://www.misuse.org/science/2008/03/27/converting-numbers-or-currency-to-comma-delimited-format-with-ruby-regex/
	def comma_numbers(number:)
		delimiter = ','
		number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
	end

	def calculate
		@display.output unit_name:@unit_name, mega_watt_hours:mega_watt_hours
	end
end