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

	def process total_entries:CSVFile.new.lines
		@units = []
		electricity_generated_this_day = []
		total_entries.each do |line|
			electricity_generated = ElectricityGeneration.new(line:line)
			electricity_generated_this_day.push electricity_generated
			@units.push({id:electricity_generated.unit_id}) unless @units.include?({id:electricity_generated.unit_id})
		end

		@units.each do |unit|
			entries_for_this_unit = electricity_generated_this_day.select do |electricity_generated| 
				electricity_generated.unit_id.eql? unit[:id] 
			end
			unit[:entries] = entries_for_this_unit
		end
	end

	def test_number_of_entries_per_unit
		process

		assert_equal 826, @units.count
		assert_equal "T_ABTH7", @units[0][:id]

		assert_equal 52, @units[0][:entries].count
	end
end