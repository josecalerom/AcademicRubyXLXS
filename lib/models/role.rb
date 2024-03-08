require_relative "base"

class Role < Base
  DEFAULT_ATTRS = [:name]

  attr_accessor *DEFAULT_ATTRS
end
