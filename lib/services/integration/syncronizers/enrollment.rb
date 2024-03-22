module Integration
  module Syncronizers
    class Enrollment < Base
      def call(sheets:)
        # criar variavel pra guardar o nome do arquivo (ano letivo)
        academic_year = AcademicYear.find_by(name: sheets.filename)
        # criar variavel pra guardar a aba Turmas
        school_classes = sheets.sheet('Turmas')

        # aqui realizar a accao de criar turmas e ano letivo
        (school_classes.first_row..school_classes.last_row).each do |number_row|
          next if number_row == 1

          row = school_classes.row(number_row)

          Integration::Actions::SchoolClassSaver.new.call(
            school_class_data: {
              external_id: row[0],
              description: row[1],
              academic_year_id: academic_year.id
            }
          )
        end

        enrollments = sheets.sheet('Matriculas')
        result = []

        (enrollments.first_row..enrollments.last_row).each do |number_row|
          next if number_row == 1

          row = enrollments.row(number_row)
          student_role = Role.find_by(name: 'student')
          parent_role = Role.find_by(name: 'parent')

          #Student.create
          Integration::Actions::UserSaver.new.call(
            user_data: {
              external_id: row[0],        # A
              name: row[1],               # B
              cpf: row[2],                # C
              birthdate: row[3].to_s,     # D
              role_id: student_role['id']
            }
          )

          #Parent.create
          Integration::Actions::UserSaver.new.call(
            user_data: {
              name: row[4],               # E
              cpf: row[5],                # F
              birthdate: row[6].to_s,     # G
              role_id: parent_role['id']
            },
            contacts_data: [
              { contactable: row[7], type: 0 },
              { contactable: row[8], type: 1 }
            ]
          )
        end

        # aqui fazer a accao de criar de fato a matricula (model parent_student_relationship)
        result
      end
    end
  end
end