require './students'
class ClassRoom
  attr_accessor :label
  attr_reader :students_list

  def initialize(label)
    @label = label
    @students_list = []
  end

  def add_student(student_name)
    @students_list.push(student_name)
    student_name.student_class = self
  end
end
