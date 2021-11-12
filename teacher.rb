require './person'

class Teacher < Person
  attr_accessor :type, :specialization

  def initialize(specialization, age, name = 'Unknown', type = 'teacher')
    super(name, age)
    @specialization = specialization
    @type = type
  end

  def can_use_service?
    true
  end
end
