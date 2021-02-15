# https://ruby-doc.org/core-2.6.6/Range.html
# https://ruby-doc.org/core-2.7.2/Enumerable.html
# https://ruby-doc.org/core-2.7.2/Array.html
# text_array = text.split(" ")

@bike.reviews {|bike| p bike.rating }

if block_given?

  (1..10).each { |i| puts "counting to #{i}" }

  grades = [19, 8, 11, 15, 13]

  def average(grades)
    count = 0
    grades.each do |grade|
      count = count + grade
      #count += grade
    end
    # average = (count / grades.length).to_f
    p count / grades.length.to_f
  end

  restaurants.select{|rest| rest.city == city}

  #example 2
  def length_finder(input_array)
    output = []
    input_array.each do |x|
      output << x.length
    end
    return output
  end

  my_array = length_finder(["first", "second", "third", "forth"])
  # => [5, 6, 5, 5]

  #example 3
  a = ['aaaa', 'bbb', 'cc', 'd']
  a.sort_by! {|element| element.size }
  a # => ["d", "cc", "bbb", "aaaa"]
  #example 4
  students = [ [ "john", 28 ], [ "mary", 25 ], [ "paul", 21 ] ]
  # Those hashes
  #should have two keys: :name and :age . What is the type of those keys?
  students.map do |student|

    has1 = {
      name: student[0],
      :age => student[1]
    }
  end

  students =     [ "Peter", "Mary", "George", "Emma" ]
  student_ages = [ 24     , 25    , 22      ,  20    ]

  # each with index behaves like HASH .each
  students.each_with_index do |student, index|
    age = student_ages[index]
    puts = " #{student} (#{age} years old)"
  end

  #example 5
  musicians = ['David Gilmour', 'Roger Waters', 'Richard Wright', 'Nick Mason']

  # get first part  with a condition
  musicians.find { |musician| musician.split(' ').first == 'John' }

  # Create
  musicians << "Michael Jackson"
  puts musicians.lenght

  # Read
  puts musicians [1]

  #Update
  musicians [0] =  "Miles Davis"

  #del
  musicians.delete_at(4)


  range = 1..10

  p range.to_a


  # find a musician :
  musicians = ['Jimmy Page', 'Robert Plant', 'John Paul Jones', 'John Bonham']

  musicians.find { |musician| musician.split(' ').first == 'John' }
  # => 'John Paul Jones'


  # for musician in musicians
  #   puts "- #{musician}"

  for i in (0...musicians.lenght)

    puts "- #{musicians[i]}"

  end

  # ace_array.collect!.with_index {|horse, index| "#{index + 1}-#{horse}!" }


  musicians.each do |musician|
    puts "Hello #{musician}"
  end

  # EACH iterates  through items && returns the array itself
  musicians.each_with_index do |musician, index|
    puts "#{index + 1}. Hello #{musician}"
  end

  # MAP will return the array that has been altered
  new_musicians = musicians.map do |musician|
    musicians.upcase
  end

  first_names = musicians.map do |musician|
    musician.split(" ").first
  end

  j_counter = musicians.count do |musician|
    musician.start_with?"J"
  end
  puts j_counter

  ## with each
  counter = 0
  musicians.each do |musician|
    if musician.start_with?("J")
      counter += 1
    end
  end

  # SELECT

  j_musicians = musician.select do |musician|
    musician.start_with?("J") &&
      musician.split(" ").last.start_with?("B")
  end

  #DELETE
  musicians.reject do |musician|
    musician.start_with? "J" # reject only the elements that start with a "J"
  end

  ### BLOCK ME ###
  # returns the last line
  numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  numbers.each_slice(2).to_a
  # => [[1, 2], [3, 4], [5, 6], [7, 8], [9]]

  # The block is just an argument

  def timer
    start_time = Time.now

    yield

    end_time = Time.now
    puts "Elapsed time : #{end_time - start_time}"

  end

  timer() do
    puts "I'm doing something slow"
    sleep(4)
    Puts "im done"
  end



  # yield can be called with parameters

  def beautify_name(first_name, last_name)
    full_name = "#{first_name.capitalize} #{last_name.upcase}"
    yield(full_name)
  end

  message = beautify_name("john", "lennon") do |name|
    "Greetings #{name}, you look quite fine today!"
  end
  puts message # => "Greetings John LENNON, you look quite fine today!"

  message = beautify_name("john", "lennon") do |name|
    "Bonjour #{name}, comment allez-vous ?"
  end
  puts message # => "Bonjour John LENNON, comment allez-vous ?"

  message = beautify_name("ringo", "starr") do |name|
    "Hey #{name}! Let's play on your #{name} drum kit!"
  end
  puts message # => "Hey Ringo STARR! Let's play on your Ringo STARR drum kit!"



  # example 2
  def greet(name)
    capitalized_name = name.capitalize
    puts yield(capitalized_name)
  end

  me = 'john'

  greet(me) do |name|
    "Greetings, #{name}, you look quite fine today!"
  end
