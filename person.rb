require 'pry'
require './corrector'

class Person
  attr_accessor :name, :age, :permission
  attr_reader :id, :corrector, :rented

  def initialize(age, name, permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @corrector = Corrector.new(@name)
    @age = age
    @permission = permission
    @rented = []
  end

  def validate_name
    @name = @corrector.correct_name
  end

  def can_use_service?
    of_age? || permission
  end

  def of_age?
    @age >= 18
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  private :of_age?
end
