require './person'
require './classroom'
class Student < Person
  attr_reader :classroom

  def initialize(classroom, age, name = 'Unknown')
    super(age, name)
    @classroom = classroom
  end

  def student_class=(classroom)
    @classroom = classroom
    classroom.students_list.push(self) unless @classroom.students_list.include?(self)
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
