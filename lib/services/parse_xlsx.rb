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
      student_role = Role.find_by(name: 'student')
      parent_role = Role.find_by(name: 'parent')

      #Student.create
			User.create(
				external_id: row[0],        # A
				name: row[1],               # B
				cpf: row[2],                # C
				birthdate: row[3].to_s,     # D
        role_id: student_role['id']
			)

      #Parent.create
			User.create(
				name: row[4],               # E
				cpf: row[5],                # F
				birthdate: row[6].to_s,     # G
        role_id: parent_role['id']
			)
		end
		result
	end
end
