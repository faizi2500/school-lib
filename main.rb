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
  puts 'Please choose an option by enterin a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given id'
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
  new_teacher = Teacher.new(teacher_speacialization, teacher_age, teacher_name)
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
  $book_list.each_with_index do |item, index|
    puts "#{index}) Title: #{item.book}, Author: #{item.author}"
    puts
  end
  book_number = gets.chomp.to_i
  if book_number > $book_list.length
    puts 'Please choose from the list'
    book_options
  end
  book_number
end

def person_options
  $person_list.each_with_index do |item, index|
    puts "#{index}) [#{item.type}] Name: #{item.name}, id: #{item.id} Age: #{item.age}"
    puts
  end
  person_number = gets.chomp.to_i
  if person_number > $person_list.length
    puts 'Please choose from the list'
    person_options
  end
  person_number
end

def create_rental
  if $book_list[0] and $person_list[0]
    rent_book = book_options
    rent_to = person_options
    puts 'Insert date in the format YYYY-DD-MM'
    print 'Date:'
    enter_date = gets.chomp
    new_rental = Rental.new(enter_date, $book_list[rent_book], $person_list[rent_to])
    puts 'Rental Created Successfully'
    $rentals << new_rental
    puts
    main
  end
  puts 'Not enough books or students found'
  puts
  main
end

def show_books
  puts 'No books added yet. Press (4) to add a book.' if $book_list.none?
  puts
  if $book_list.length.positive?
    puts 'Book List'
    $book_list.each do |item|
      puts "Book: #{item.book}, Author: #{item.author}"
      puts
    end
  end
  puts
  main
end

def show_person
  puts 'Nothing added to person list yet. Press (3) to add a person' if $person_list.none?
  puts
  if $person_list.length.positive?
    puts 'Person List'
    $person_list.each do |val|
      puts
      print "#{val.type}-ID: (#{val.id}): Name: #{val.name} Age: #{val.age} Allowed: #{val.permission}"
      puts
    end
  end
  puts
  main
end

def get_list(list_value)
  show_books if list_value == '1'
  show_person
end

def search_id(person_id)
  puts 'Rentals:'
  $rentals.each do |i|
    puts "Date: #{i.date}, Book '#{i.book.title}' by #{i.book.author}" if i.person.id == person_id
  end
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
    get_list('1')
  when '2'
    get_list('2')
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
