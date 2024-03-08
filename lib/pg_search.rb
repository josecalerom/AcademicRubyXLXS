require 'pg'
require 'dotenv'
require 'singleton'

Dotenv.load

class PgSearch
  include Singleton

  attr_reader :connections

  DEFAULT_CONFIG = {
    dbname: "",
    host: ENV['DB_HOST'],
    port: ENV['DB_PORT'],
    user: ENV['DB_USER'],
    password: ENV['DB_PASS']
  }

  # provides the array config [{dbname: ''}, {dbname: ''}]
  def initialize
    @connections ||= {}

    # ['academic_development', 'postgres']
    [ENV['DB_NAME'], ENV['DB_ADMIN_NAME']].each do |dbname|
      db_config = DEFAULT_CONFIG.merge(dbname: dbname)

      connect(**db_config) unless @connections[db_config[:dbname]]
    end

    at_exit { @connections.each { |dbname, _| disconnect(dbname) } }      # Garante que a conexão será fechada ao sair da aplicação
    trap('INT') { @connections.each { |dbname, _| disconnect(dbname) } }  # Captura o sinal de interrupção (Ctrl+C) para fechar a conexão
  end

  def exec_query(dbname, query="")
    dbname = dbname.to_s

    raise "The database #{dbname} is not connected" unless @connections[dbname]

    @connections[dbname].exec(query)
  end

  def connect(config = {})
    raise 'provide the database name' unless config[:dbname]

    @connections[config[:dbname]] ||= PG.connect(**config)
  rescue PG::ConnectionBad => e
    nil
  end

  def disconnect(dbname)
    dbname = dbname.to_s

    return unless @connections.any?

    @connections[dbname].close if @connections[dbname]
    @connections.delete(dbname)
  end
end
