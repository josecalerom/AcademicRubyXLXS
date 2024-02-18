require 'pg'

module Base
	extend self

	def connect
		PG.connect(
			dbname: 'academic_development',
			host: '172.18.48.1',
			port: '4321',
			user: 'postgres',
			password: '*R8:KqD1234i7hR+9HZsaGH98A3'
		)
	end

	def exec(query="")
		result = connect.exec query
		connect.close
		result.to_a
	end
end
