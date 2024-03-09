require_relative "base"

class School_Class < Base
  DEFAULT_ATTRS = [:external_id, :description, :academic_year]

  attr_accessor *DEFAULT_ATTRS
end
