require 'time'
require_relative 'base'

class Student
	def self.all
    Base.exec("
			SELECT
				users.id,
				users.name,
				users.cpf,
				users.birthdate,
				users.external_id,
				users.role_id
			FROM users
				JOIN roles
					ON roles.id = users.role_id
					AND roles.name = 'student'
		")
  end

	def self.create(name:, cpf:, birthdate:, external_id: 'NULL')
		role_id = Base.exec("SELECT * FROM roles WHERE name = 'student'").first['id'].to_i
		birthdate = Date.parse(birthdate).to_s

		Base.exec("
			INSERT INTO users (name, cpf, birthdate, external_id, role_id)
			VALUES ('#{name}', '#{cpf}', '#{birthdate}', #{external_id}, #{role_id})
		")
	end
end
