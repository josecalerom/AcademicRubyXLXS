require_relative "base"

class User < Base
  attr_accessor :name, :cpf, :birthdate, :external_id, :role_id

  def initialize(**args)
    @name = args[:name]
    @cpf = args[:cpf]
    @birthdate = args[:birthdate]
    @external_id = args[:external_id]
    @role_id = args[:role_id]
  end
end
