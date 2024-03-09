require_relative "base"

class Subject < Base
  DEFAULT_ATTRS = [:name, :teacher_id]

  attr_accessor *DEFAULT_ATTRS
end
