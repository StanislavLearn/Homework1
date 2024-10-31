require 'date'

class Student
  attr_reader :surname, :name, :birth_date
  @@students = []
  
  def initialize(name, surname, birth_date)
    @name = name
    @surname = surname
    @birth_date = birth_date
    validate_date_of_birth
    add_student
  end

  def validate_date_of_birth
    raise ArgumentError, 'Invalid date' unless birth_date.is_a?(Date)
    raise ArgumentError, 'Birth date can not be in the future' if birth_date > Date.today
  end

  def self.students 
    @@students 
  end

  def calculate_age
    age = Date.today.year - birth_date.year
  end

  def add_student
    if self.class.students.any? { |s| s.name == name  && s.surname == surname  && s.birth_date == birth_date }
      puts "This student already exists."
    else
      self.class.students << self
      puts "#{name} #{surname} has been added to list."
    end 
  end

  def remove_student
    puts "\n#{self.name}, #{self.surname}, #{self.birth_date} has been deleted"
      self.class.students.delete(self)
  end 

  def self.get_students_by_age(age)
    selected_students = students.select { |s| s.calculate_age == age }
    selected_students.each do |s|
      puts "#{s.name} #{s.surname}, birth Date: #{s.birth_date}"
    end
  end

  def self.get_students_by_name(name)
    selected_students = students.select { |s| s.name == name }
    selected_students.each do |s|
      puts "#{s.name} #{s.surname}, birth Date: #{s.birth_date}"
    end
  end
end

class Program

  def initialize 
    main
  end

  def main
    begin
      student1 = Student.new("Gregroz", "Blaskskoskolyevich", Date.new(2004, 10, 29))
      student2 = Student.new("Yevgenia", "Chub", Date.new(2002, 8,29))
      student3 = Student.new("Yulia", "Kravchuk", Date.new(2000, 5, 4))
      student4 = Student.new("Valeriy", "Zlobonosniy", Date.new(2003, 5, 13))
      student5 = Student.new("Stanislav", "Gonchinskiy", Date.new(2003, 8, 21))
      student6 = Student.new("Ivan", "Skovorodov", Date.new(2005, 3, 28))
      student7 = Student.new("Petro", "Ivanov", Date.new(2003, 6, 4))
      student8 = Student.new("Stanislav", "Chub", Date.new(2004, 8, 29))
      student9 = Student.new("Boris", "Yachenko", Date.new(2077, 1 ,1))
      
    rescue ArgumentError => e
      puts e.message
    ensure
      
      puts "\nStudents that aged 20:"
      Student.get_students_by_age(20)

      puts "\nStudents which named Stanislav:"
      Student.get_students_by_name("Stanislav")
      
      student5.remove_student
      
      puts "\nStudents which named Stanislav:"
      Student.get_students_by_name("Stanislav")
      
    end
  end
end

program = Program.new