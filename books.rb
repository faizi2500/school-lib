class Books
  attr_accessor :book, :author
  attr_reader :rented

  def initialize(book, author)
    @book = book
    @author = author
    @rented = []
  end

  def add_rental(person, date)
    Rental.new(date, self, person)
  end
end
