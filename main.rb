#!/usr/bin/env ruby

require 'pry'
require './books'
require './classroom'
require './corrector'
require './person'
require './rental'
require './students'
require './teacher'

NEW_LINE = "\n".freeze

$person_list = []
$book_list = []
$rentals = []

def menu
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
  print 'What do you want to do today: '
end

# Methods for creating Student or teacher object

def create_person
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  user_person_creation_input = gets.chomp
  if %w[1 2].include?(user_person_creation_input)
    create_person_obj(user_person_creation_input)
  else
    create_person
  end
end

def validate_permission(val)
  status = val.upcase
  if %w[Y N].include?(status)
    status
  else
    print 'Please type (Y) if student has permission, otherwise (N): '
    parental_permission = gets.chomp
    validate_permission(parental_permission)
  end
end

def create_new_student
  print 'Age: '
  student_age = gets.chomp
  print 'Name: '
  student_name = gets.chomp
  print 'Parent Permission (Y/N): '
  parental_permission = gets.chomp
  permission_status = validate_permission(parental_permission)
  print 'Student Class (optional): '
  student_class = gets.chomp

  if permission_status == 'Y'
    new_student = Student.new(student_class, student_age, student_name)
  else
    parent_status = false
    new_student = Student.new(student_class, student_age, student_name, parent_status)
  end
  sleep(1)
  print "Person created successfully\n"
  $person_list << new_student
  puts
  main
end

def create_new_teacher
  print 'Age: '
  teacher_age = gets.chomp.to_i
  print 'Name: '
  teacher_name = gets.chomp
  print 'Specialization: '
  teacher_speacialization = gets.chomp
  new_teacher = Teacher.new(teacher_speacialization, teacher_name, teacher_age)
  sleep(1)
  print "Person created successfully\n"
  $person_list << new_teacher
  puts
  main
end

def create_person_obj(student_or_person)
  if student_or_person == '1'
    create_new_student
  else
    create_new_teacher
  end
end

# Methods for creating student or teacher object ends here

# Create book methods
def create_book
  print 'Title: '
  book_title = gets.chomp
  print 'Author: '
  book_author = gets.chomp
  new_book = Books.new(book_title, book_author)
  sleep(1)
  print "Book created successfully\n"
  $book_list << new_book
  puts
  main
end

# Create book method end

# Create rental

def book_options
  if $book_list.size.zero?
    puts 'No books'
  else
    puts "List of all books: \n"
    $book_list.each_with_index { |item, index| puts "#{index + 1}- Title: #{item.book}, Author: #{item.author}" }
    book_number = gets.chomp
    $book_list.each_with_index { |book, index| @selected_book = book if (index + 1) == book_number.to_i }
    @selected_book
  end
end

def person_options
  if $person_list.size.zero?
    puts 'No people exist'
  else
    puts 'List of all members'
    $person_list.each do |person|
      puts "[#{person.type}] Name: #{person.name} | Id: #{person.id} | Age: #{person.age} \n"
    end
    person_id = gets.chomp
    $person_list.each { |person| @selected_person = person if person.id == person_id.to_i }
    @selected_person
  end
end

def create_rental
  puts 'Select book from the list'
  @rent_book = book_options
  puts "Select a person fome the following list of members by id:\n"
  @rent_to = person_options
  puts 'Date:'
  date = gets.chomp
  if @selected_person && @selected_book
    $rentals << Rental.new(date, @rent_book, @rent_to)
    puts 'Rental created seccussfully'
  else
    puts 'Something went wrong. Please try again.'
    create_rental
  end
  puts
  main
end

def show_books
  if $book_list.size.zero?
    puts 'No books'
  else
    puts "List of all books: \n"
    $book_list.each_with_index { |item, index| puts "#{index + 1}- Title: #{item.book}, Author: #{item.author}" }
  end
  main
end

def show_person
  if $person_list.size.zero?
    puts 'No people exist'
  else
    puts 'List of all members'
    $person_list.each do |person|
      puts "[#{person.type}] Name: #{person.name} | Id: #{person.id} | Age: #{person.age} \n"
    end
  end
  puts
  main
end

def search_id(person_id)
  puts 'Rentals by Person Id:'
  $rentals.each do |i|
    puts "Date: #{i.date}, Book '#{i.book.book}' by #{i.book.author}" if i.person.id == person_id
  end
  puts
  main
end

def rented_on_id
  print 'ID of person: '
  user_id = gets.chomp.to_i
  search_id(user_id)
end

# rubocop:disable Metrics
def input_cases(input_received)
  case input_received
  when '1'
    show_books
  when '2'
    show_person
  when '3'
    create_person
  when '4'
    create_book
  when '5'
    create_rental
  when '6'
    rented_on_id
  when '7'
    puts "Please type main to start the console again.\nThank You!!"
    exit
  else
    puts "Wrong value inserted. Try again\n"
    main
  end
end

def main
  menu
  input_received = gets.chomp
  input_cases(input_received)
end

# rubocop:enable Metrics

main
