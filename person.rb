class Person
  attr_accessor :name, :age, :permission
  attr_reader :id

  def initialize(age, name = 'Unknown', permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @permission = permission
  end

  def can_use_service?
    is_of_age || permission
  end

  def of_age?
    :age >= 18
  end

  private :of_age?
end