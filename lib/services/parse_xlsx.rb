require 'roo'

class ParseXlsx
	def initialize(filename)
		@filename = filename
	end

	def call
		xlsx = Roo::Spreadsheet.open(@filename)
		sheet1 = xlsx.sheet('Matriculas')
		result = []
		(sheet1.first_row..sheet1.last_row).each do |number_row|
			next if number_row == 1

			row = sheet1.row(number_row)
			result << {
				external_id: row[0],
				name: row[1],
				cpf: row[2],
				birthdate: row[3].to_s
			}
		end
		result
	end
end
