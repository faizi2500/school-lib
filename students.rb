# rubocop: disable Style/OptionalBooleanParameter

require './person'
require './classroom'

class Student < Person
  attr_reader :classroom
  attr_accessor :type

  def initialize(classroom, age, name = 'Unknown', permission = true, type = 'student')
    super(age, name, permission)
    @classroom = classroom
    @type = type
  end

  def student_class=(classroom)
    @classroom = classroom
    classroom.students_list.push(self) unless @classroom.students_list.include?(self)
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end

# rubocop: enable Style/OptionalBooleanParameter
