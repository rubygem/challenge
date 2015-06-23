require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')


class AllTheTests < Test::Unit::TestCase
	def generated_electricity
		line = CSVFile.new.lines[0]
		ElectricityGeneration.new(line:line)
	end

	def test_read_physical_notification
		assert_equal "PN", generated_electricity.physical_notification
	end

	def test_read_unit_id
		assert_equal "T_ABTH7", generated_electricity.unit_id
	end

	def test_read_settlement_period
		assert_equal "5", generated_electricity.settlement_period
	end

	def test_read_started
		assert_equal "20110712010000", generated_electricity.started
	end

	def test_read_finished
		assert_equal "20110712013000", generated_electricity.finished
	end

	def test_read_start_output_level
		assert_equal "485.000", generated_electricity.start_output_level
	end

	def test_read_finished_output_level
		assert_equal "485.000", generated_electricity.finished_output_level
	end
end