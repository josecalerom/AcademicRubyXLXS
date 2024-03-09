require_relative "base"

class Parent_Student_School_Class < Base
  DEFAULT_ATTRS = [:parent_student_id, :school_class_id]

  attr_accessor *DEFAULT_ATTRS
end
