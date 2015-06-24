require_relative('ElectricityGeneration')

class Units
	def initialize total_entries:
		@units = []
		@electricity_generated_this_day = []
		process total_entries:total_entries
		process_entries
	end

	def process_entries
		@units.peach do |unit|
			unit[:entries] = @electricity_generated_this_day.select do |electricity_generated| 
				electricity_generated.unit_id.eql? unit[:id] 
			end
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