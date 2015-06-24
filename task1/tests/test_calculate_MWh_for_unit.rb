require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')

class TestCalculateMegaWattHours < Test::Unit::TestCase
	def test_total_number_of_entries_in_file
		total_entries = CSVFile.new.lines
		total_number_of_entries = 40947
		assert_equal total_number_of_entries, total_entries.count
	end

	def process_total_entries
		total_entries = CSVFile.new.lines
		@units = []
		converted_csv_lines = []
		total_entries.each do |line|
			electricity_generated = ElectricityGeneration.new(line:line)
			converted_csv_lines.push electricity_generated
			@units.push({id:electricity_generated.unit_id}) unless @units.include?({id:electricity_generated.unit_id})
		end
	end

	def test_number_of_entries_per_unit
		process_total_entries

		assert_equal 826, @units.count
		assert_equal "T_ABTH7", @units[0][:id]

		# units.each do |unit|
		# 	entries_for_this_unit = converted_csv_lines.select do |electricity_generated| 
		# 		electricity_generated.unit_id.eql? unit[:id] 
		# 	end
		# 	unit[:entries] = entries_for_this_unit
		# end

		# assert_equal 826, units[0][:entries].count
	end
end