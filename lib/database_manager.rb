require 'dotenv'
require_relative 'pg_search'

Dotenv.load

module DatabaseManager
  extend self

  # Use: DatabaseManagement.create
  def create
    log_info 'Starting DB create...'

    PgSearch
      .instance
      .exec_query(ENV['DB_ADMIN_NAME'], "SELECT 1 FROM pg_database WHERE datname = '#{ENV['DB_NAME']}'")
      .then do |result|
        return log_warn "O banco de dados já existe!" unless result.ntuples == 0

        PgSearch.instance.exec_query(ENV['DB_ADMIN_NAME'], "CREATE DATABASE #{ENV['DB_NAME']}")
        log_info "Banco de dados '#{ENV['DB_NAME']}' criado com sucesso!"
      end
  rescue PG::Error => e
    log_error "Ocorreu um erro ao criar o banco de dados: #{e.message}"
  ensure
    log_message 'Exit db create.'
  end

  # Use: DatabaseManagement.migrate
  def migrate
    log_info 'Starting DB migrate...'

    Dir.glob('lib/db/migrate/*.sql').each do |file|
      match = file.match(/\/(\d+)_(\w+)\.sql/)
      migration_number = match[1].to_i
      migration_name = match[2]

      query = File.read(file)#.chomp.gsub(/\s+/, ' ').gsub(/\(\s+/, '(').gsub(/\s+\)/, ')')

      begin
        PgSearch.instance.exec_query(ENV['DB_NAME'], query)

        log_info "migration \"#{migration_name}\" executed successfully"
      rescue PG::Error => e
        if e.message.match?(/already exists/)
          log_warn e.message.sub(/^ERROR:  /, '')
          next
        end

        log_error "Ocorreu um erro ao executar a migration: #{e.message}"; break
      end
    end
  ensure
    log_message 'Exit db migrate'
  end

  # Use: DatabaseManagement.drop
  def drop
    log_info 'Starting DB destroy...'

    PgSearch.instance.disconnect(ENV['DB_NAME'])
    PgSearch
      .instance
      .exec_query(ENV['DB_ADMIN_NAME'], "DROP DATABASE IF EXISTS #{ENV['DB_NAME']}")
      .then { |result| log_info "Banco de dados '#{ENV['DB_NAME']}' destruído com sucesso!" }
  rescue PG::Error => e
    log_error "Ocorreu um erro ao destruir o banco de dados '#{ENV['DB_NAME']}': #{e.message}"
  ensure
    log_message 'Exit db destroy'
  end

  private

  def log_info(message)
    prefix = "INFO -- : "
    log_message(prefix.rjust(prefix.length + 2).concat(message))
  end

  def log_warn(message)
    prefix = "WARN -- : "
    log_message(prefix.rjust(prefix.length + 2).concat(message))
  end

  def log_error(message)
    prefix = "ERROR -- : "
    log_message(prefix.rjust(prefix.length + 2).concat(message))
  end

  def log_message(message)
    puts message
  end
end
