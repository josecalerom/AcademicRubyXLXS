require_relative '../pg_search'

  # This is an Model Interface
  class Base
    # This module provides the exec_query method for searching the database
    include PgSearch

    ALLOWED_TABLES = ['User', 'Role']

    # Lista todos os registros do banco de dados
    # Use: Model.all
    def self.all
      raise StandardError, 'The Base class is not a table' unless ALLOWED_TABLES.include? name

      table_name = name.downcase.concat('s')

      exec_query("SELECT #{table_name}.* FROM #{table_name}").to_a
    end

    # Cria um registro do model no DB
    # Use: Model.create(args)
    def self.create(**args)
      new(**args).save
    end

    def self.find_by(**args)
      args.map{ |k, v| self.all.select { |r| r[k.to_s] == v }.first }.first
    end

    # Salva um registro do objeto no DB
    # Use: Model.new.save
    def save
      attribs = instance_variables.map { |v| v.to_s.gsub('@', '') }
      values = attribs.map { |v| send v }

      exec_query(%{
        INSERT INTO #{self.class.name.downcase.concat('s')} (#{attribs.join(', ')})
        VALUES (#{values.map{ |v| "'#{v}'" }.join(', ')})
      })
    end

    # Atualiza o registro do objeto no DB
    # Use: Model.new.update(args)
    def update()
    end

    # Deletar o registro do objeto no DB
    # Use: Model.new.save
    def delete
    end
  end
