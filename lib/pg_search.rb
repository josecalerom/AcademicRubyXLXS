require 'pg'

module PgSearch
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def exec_query(query="")
      connect.exec(query).tap { disconnect }
    end

    private

    def connect
      @connection ||= PG.connect(
        dbname: 'academic_development',
        host: '172.18.48.1',
        port: '4321',
        user: 'postgres',
        password: '*R8:KqD1234i7hR+9HZsaGH98A3'
      )
    end

    def disconnect
      @connection.close if @connection
      @connection = nil
    end
  end

  def exec_query(query="")
    self.class.send(:exec_query, query)
  end
end
