require_relative "base"

class Contact < Base
  DEFAULT_ATTRS = [:contactable, :type, :user_id]

  attr_accessor *DEFAULT_ATTRS
end
