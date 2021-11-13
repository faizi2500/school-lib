class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date

    @book = book
    book.rented << self

    @person = person
    person.rented << self
  end
end
