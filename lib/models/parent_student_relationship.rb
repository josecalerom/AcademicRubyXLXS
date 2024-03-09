require_relative "base"

class Parent_Student_Relationship < Base
  DEFAULT_ATTRS = [:parent_id, :student_id, :school_class_id]

  attr_accessor *DEFAULT_ATTRS
end
