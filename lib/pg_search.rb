require 'pg'
require 'dotenv'

Dotenv.load

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
        dbname: ENV['DB_NAME']
        host: ENV['DB_HOST']
        port: ENV['DB_PORT']
        user: ENV['DB_USER']
        password: ENV['DB_PASS']
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
