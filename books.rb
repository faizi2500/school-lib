class Books
  attr_accessor :book, :author
  attr_reader :rented

  def initialize(book, author)
    @book = book
    @author = author
    @rented = []
  end
end
