class CSVFile
	NEW_LINES = /\r?\n/
	def initialize location:"../../data", file_name:"tib_messages_FPN.2011-07-12"
		csv_file = File.expand_path("#{location}/#{file_name}", __FILE__)
		@csv = File.read(csv_file)
	end

	def lines 
		@csv.split(NEW_LINES)
	end
end