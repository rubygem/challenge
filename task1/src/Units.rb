require_relative('ElectricityGeneration')
require 'peach'

class Units
	def initialize total_entries:
		@units = []
		@electricity_generated_this_day = []
		process total_entries:total_entries
		process_entries
	end

	def process_entries
		@units.peach do |unit|
			entries = entries_for_unit id:unit[:id]
			unit[:entries] = entries
			unit[:mega_watt_hours] = MegaWattHours.new(entries_for_unit:entries).calculate
		end
	end

	def entries_for_unit id:
		@electricity_generated_this_day.select do |electricity_generated| 
			electricity_generated.unit_id.eql? id 
		end
	end

	def process total_entries:
		total_entries.each do |line|
			electricity_generated = ElectricityGeneration.new(line:line)
			@electricity_generated_this_day.push electricity_generated
			add_unit id:electricity_generated.unit_id
		end
	end

	def add_unit id:
		@units.push({id:id}) unless @units.include?({id:id})
	end

	def to_array
		@units
	end
end

class MegaWattHours
	def initialize entries_for_unit:
		@entries_for_unit = entries_for_unit
	end

	def calculate
		300000
	end
end