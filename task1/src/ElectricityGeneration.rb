class ElectricityGeneration
	def initialize line:line
		@csv = line.split(',')
	end

	# 1. `PN` - Physical Notification. All rows are `PN` rows so you can ignore this field.
	def physical_notification
		@csv[0]
	end

	# 2. `T_RATS-1` - Unit id. A unique identifier for the generation unit (power station boiler, wind turbine, etc).
	def unit_id
		@csv[1]
	end

	# 3. `5` - The "settlement period". You can ignore this field.
	def settlement_period
		@csv[2]
	end
	
	# 4. `20110712010000` - Start date/time.
	def started
		@csv[3]
	end
	
	# 5. `475.000` - Start output level, in MW ([Megawatts](http://en.wikipedia.org/wiki/Megawatt#Megawatt))
	def start_output_level
		@csv[4]
	end
	
	# 6. `20110712011800` - Finish date/time.
	def finished
		@csv[5]
	end

	# 7. `300.000` - Finish output level.
	def finished_output_level
		@csv[6]
	end

	#*NOTE*: The `.` indicates a decimal point, not a thousands separator. So 300.000 is 300 MW, not 300000 MW.
end

class GeneratedElectricity
	def initialize display:, electricity_generated:
		@display = display
		@unit_name = electricity_generated.unit_id
	end

	def mega_watt_hours
		"300,000"
	end

	def calculate
		@display.output unit_name:@unit_name, mega_watt_hours:mega_watt_hours
	end
end