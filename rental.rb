require 'date'

class Rental
  def initialize(person, book, date = Date.today)
    @date = date

    @person = person
    person.rentals << self unless person.rentals.include?(self)

    @book = book
    book.rentals << self unless book.rentals.include?(self)
  end
  attr_accessor :date
end
