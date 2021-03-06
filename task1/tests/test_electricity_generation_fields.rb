require 'bundler/setup'
require 'test/unit'
require_relative('../src/CSVFile')
require_relative('../src/ElectricityGeneration')

#line 718
#PN,T_SUTB-1,5,20110712010000,373.000,20110712010100,374.000

class TestReadCSVFields < Test::Unit::TestCase
	def generated_electricity
		line = CSVFile.new.lines[717]
		ElectricityGeneration.new(line:line)
	end

	def test_read_physical_notification
		assert_equal "PN", generated_electricity.physical_notification
	end

	def test_read_unit_id
		assert_equal "T_SUTB-1", generated_electricity.unit_id
	end

	def test_read_settlement_period
		assert_equal "5", generated_electricity.settlement_period
	end

	def test_read_started
		assert_equal "20110712010000", generated_electricity.started
	end

	def test_read_finished
		assert_equal "20110712010100", generated_electricity.finished
	end

	# def test_time
	# 	assert_equal "100", generated_electricity.time
	# end

	def test_power
		assert_equal 1.0, generated_electricity.power
	end

	def test_read_start_output_level
		assert_equal 373.0, generated_electricity.start_output_level
	end

	def test_read_finished_output_level
		assert_equal 374.0, generated_electricity.finished_output_level
	end
end