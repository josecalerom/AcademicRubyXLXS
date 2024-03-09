require 'dotenv'
require_relative '../pg_search'

Dotenv.load

# This is an Model Interface
class Base
  ALLOWED_TABLES = %w[User Role Contact School_Class Parent_Student_Relationship Subject School_Class_Subject Parent_Student_School_Class]

  def initialize(**args, &block) # new
    initialize_attrs(args, &block)
  end

  def self.valid_table
    raise StandardError, 'The `Base` class is not a database table' unless ALLOWED_TABLES.include? name
  end

  def self.table_name
    valid_table

    name.downcase.end_with?('s') ? name.downcase.concat('es') : name.downcase.concat('s')

  end

  # Lista todos os registros do banco de dados
  # Use: Model.all
  def self.all
    valid_table

    PgSearch.instance.exec_query(ENV['DB_NAME'], "SELECT #{table_name}.* FROM #{table_name}").to_a
  end

  # Cria um registro do model no DB
  # Use: Model.create(args)
  def self.create(**args)
    valid_table

    new(**args).save
  end

  def self.find_by(**args)
    valid_table

    filter_data = args.map do |k, v|
      "#{table_name}.#{k} = ".concat("'#{v}'")
    end

    PgSearch
      .instance
      .exec_query(ENV['DB_NAME'], "SELECT #{table_name}.* FROM #{table_name} WHERE #{filter_data.join(' AND ')}")
      .first
  end

  # Salva um registro do objeto no DB
  # Use: Model.new(..).save
  def save
    attrs = instance_variables.map { |v| v.to_s.gsub('@', '') }
    values = attrs.map { |v| send v }

    updated_name = self.class.name.downcase.end_with?('s') ? self.class.name.downcase.concat('es') : self.class.name.downcase.concat('s')

    PgSearch.instance.exec_query(ENV['DB_NAME'], %{
      INSERT INTO #{updated_name} (#{attrs.join(', ')})
      VALUES (#{values.map{ |v| "'#{v}'" }.join(', ')})
    }).then { |result| result.cmd_tuples.positive? }
  end

  # Atualiza o registro do objeto no DB
  # Use: Model.new.update(args)
  def update()
  end

  # Deletar o registro do objeto no DB
  # Use: Model.new.save
  def delete
  end
  private

  def initialize_attrs(args = {}, &block)
    # this method self is an instance
    self.class::DEFAULT_ATTRS # this is an constant that class
      .each_with_object(nil) # concat with nil for each element of constant
      .to_h # convert to Hash (Object)
      .merge(args) # merge with args of command new
      .each do |key, value| # for each object Hash, do key and value
        raise ArgumentError, "Argument '#{key}' is not a #{self.class} attribute" unless respond_to?("#{key}=".to_sym)

        instance_variable_set("@#{key}", value)
      end

    # run block case provided
    yield(self) if block_given?
  end
end
