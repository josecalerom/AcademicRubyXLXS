require_relative "base"

class User < Base
  DEFAULT_ATTRS = [:name, :cpf, :birthdate, :external_id, :role_id]

  attr_accessor *DEFAULT_ATTRS
end
