require 'pg'

module PgConnector
  # This method exec a CRUD query
  def exec_query(query="")
    result = connect.exec query
    connect.close
    result
  end

  private

  # This connect pg databse method
  def connect
    PG.connect(
      dbname: 'academic_development',
      host: '172.18.48.1',
      port: '4321',
      user: 'postgres',
      password: '*R8:KqD1234i7hR+9HZsaGH98A3'
    )
  end
end
