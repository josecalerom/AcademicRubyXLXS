require_relative "base"

class Role < Base
  attr_accessor :name

  def initialize(**args)
    @name = args[:name]
  end
end
