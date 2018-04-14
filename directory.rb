@students = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
    case selection
    when "1"
     input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def input_students
   puts "Please enter the name, hobby, country of birth for the students"
   puts "To finish, just hit return four times"
   # create an empty array
   @students
   # get the first name
   name = gets.chomp
   hobby = gets.chomp
   country = gets.chomp
   cohort = gets.chomp
   cohort = "november" if cohort.empty?

   while !name.empty? || !hobby.empty? || !country.empty? do
     # add the student hash to the array
     @students << {name: name, hobby: hobby, country: country, cohort: cohort, }
      if @students.count == 1
        puts "Now we have #{@students.count} student"
      else
        puts "Now we have #{@students.count} students"
      end
     # get another name from the user
     name = gets.chomp
     hobby = gets.chomp
     country = gets.chomp
     cohort = gets.chomp
     cohort = "november" if cohort.empty?
   end
   # return the array of input_students
   @students
end

def print_header
  puts "The students of Villains Academy".center(40)
  puts "-------------".center(40)
end

def print_cohorts
  student_by_cohort = {}
  @students.each do |student|
    cohort = student[:cohort]

  if student_by_cohort[cohort] == nil
    student_by_cohort[cohort] = []
  end

    student_by_cohort[cohort].push(student[:name])
  end
  puts student_by_cohort
end

def print_students_list
  @students.each.with_index(1) do |student, index|
      if student[:name].to_s.start_with?('S') == true && student[:name].to_s.length < 12
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)".center(40)
     end
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(40)
end

interactive_menu
