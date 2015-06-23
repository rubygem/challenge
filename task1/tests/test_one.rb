require 'bundler/setup'
require 'test/unit'

class AllTheTests < Test::Unit::TestCase
	def test_something
		csv_file = File.expand_path('../../data/tib_messages_FPN.2011-07-12', __FILE__)
		electricity_generation = File.read(csv_file)
		lines_of_csv_file = electricity_generation.split(/\r?\n/)
		first_line = lines_of_csv_file[0] 
		assert_equal "PN,T_ABTH7,5,20110712010000,485.000,20110712013000,485.000", first_line
		csv = first_line.split(',')
		physical_notification = csv[0]
		assert_equal "PN", physical_notification

	end
end
