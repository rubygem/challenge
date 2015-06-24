require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')

class TestCalculateMegaWattHours < Test::Unit::TestCase
	def test_total_number_of_entries_in_file
		entries_for_unit = 0
		total_entries = CSVFile.new.lines
		total_number_of_entries = 40947
		assert_equal total_number_of_entries, total_entries.count
	end

	def test_mega_watt_hours
		entries_for_unit = 0
		total_entries = CSVFile.new.lines
		total_entries.each do |line|
			electricity_generated = ElectricityGeneration.new(line:line)
			if electricity_generated.unit_id.eql? "T_ABTH7" 
				entries_for_unit =+ 1
			end
		end
		assert_equal entries_for_unit, 1
	end
end