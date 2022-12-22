#!/usr/bin/env ruby
require './student'
require './teacher'
require './book'
require './rental'

class App
  def show_interactive_console
    puts ''
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def run
    books = []
    people = []
    puts 'Welcome to School Library App!'
    show_interactive_console
    option = gets.chomp.to_i
    while option != 7
      case option
      when 1
        list_books(books)
      when 2
        list_people(people)
      when 3
        create_person(people)
      when 4
        create_book(books)
      when 5
        create_rental(books, people)
      when 6
        list_rentals_for_person_id(books, people)
      else
        puts 'That is not a valid option'
      end
      show_interactive_console
      option = gets.chomp.to_i
    end
    puts 'Thank you for using this app!'
  end

  def list_books(books)
    if books.empty?
      puts 'No books found'
    else
      books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    end
  end

  def list_people(people)
    if people.empty?
      puts "No people found"
    else
      people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    end
  end

  def create_person(people)
    print "Do you want to create a student (1) or a teacher (2)? [Input the number]: "
    option = gets.chomp.to_i
    case option
    when 1
      create_student(people)
    when 2
      create_teacher(people)
    else
      puts "That is not a valid input"
    end
  end

  def create_student(people)
    print "Age: "
    age = gets.chomp.to_i
    print "Name: "
    name = gets.chomp
    print "Has parent permission? [Y/N]: "
    parent_permission = gets.chomp
    parent_permission = parent_permission.downcase == "y"
    student = Student.new(age, name, parent_permission)
    puts "Person created successfully"
    people.push(student)
  end

  def create_teacher(people)
    print "Age: "
    age = gets.chomp.to_i
    print "Name: "
    name = gets.chomp
    print "Specialization: "
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    puts "Person created successfully"
    people.push(teacher)
  end

  def create_book(books)
    print "Title: "
    title = gets.chomp
    print "Author: "
    author = gets.chomp
    book = Book.new(title, author)
    puts "Book created successfully"
    books.push(book)
  end

  def create_rental(books, people)
    puts "Select a book from the following list by number"
    books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_index = gets.chomp.to_i
    puts "Select a person from the following list by number (not id)"
    people.each_with_index { |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    }
    person_index = gets.chomp.to_i
    print "Date: "
    date = gets.chomp
    rental = Rental.new(date, people[person_index], books[book_index])
    puts "Rental created successfully"
  end

  def list_rentals_for_person_id(books, people)
    print "ID of person: "
    id = gets.chomp.to_i
    puts "Rentals:"
    people.each do |person|
      if person.id == id
        person.rentals.each { |rental|
          puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
        }
      end
    end
  end
end
