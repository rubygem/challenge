require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/Units')

class TestCalculateMegaWattHours < Test::Unit::TestCase
	def test_number_of_entries_per_unit
		units = Units.new(total_entries:CSVFile.new.lines).to_array

		assert_equal 826, units.count
		sorted = units.sort_by do |unit|
			unit[:id]
		end

		first_entry = sorted[0]

		assert_equal "2__ABGAS000", first_entry[:id]

		assert_equal 48, first_entry[:entries].count
	end
end