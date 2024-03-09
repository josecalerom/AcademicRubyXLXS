require_relative "base"

class School_Class_Subject < Base
  DEFAULT_ATTRS = [:school_class_id, :subject_id, :teacher_id]

  attr_accessor *DEFAULT_ATTRS
end
