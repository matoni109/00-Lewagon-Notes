# https://docs.ruby-lang.org/en/2.3.0/Array.html?search=string+contains+a+word#method-i-include-3F
# https://docs.ruby-lang.org/en/2.3.0/Date.html
# require "date"  Date.today
# ruby is truthy

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

numbers.each_slice(2).to_a
# => [[1, 2], [3, 4], [5, 6], [7, 8], [9]]

numbers.reject { |delete| delete == 3 }
# remove 3


FLOW STUFF

i = 1

until @product_names.length < i do
    puts "#{i} #{@product_names[i-1]}"
    i += 1
  end


  (5..25).to_a
  # => [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]

  race_array.collect!.with_index {|horse, index| "#{index + 1}-#{horse}!" }

  ["", "22", "14", "18"].map(&:to_i)
  # Result: [0, 22, 14, 18]

  ["", "22", "14", "18"].reject(&:empty?).map(&:to_i)
  # Result: [22, 14, 18]

  ["", "22", "14", "18"].grep(/\d+/)
  #=> ["22", "14", "18"]

  ["", "22", "14", "18"].grep(/\d+/, &:to_i)
  #=> [22, 14, 18]

  condition = age >= 18

  puts "How old are you?"
  age = gets.chomp.to_i
  # unless

  if age >= 18
    puts "you can Vote"
  else
    puts "you can not Vote"
  end

  # ternary oporator

  computer_coin = [ "heads", "tails"].sample

  puts "heads or tails"
  player_coin = gets.chomp.to_s


  if computer_coin == player_coin
    verb  = "won"
  else
    verb = "lost"

  end

  puts "You #{verb}"

  #  condition ? code_if_truthy : code_if_false


  verb = (computer_coin == player_coin) ? "won" : "lost"

  puts "You #{verb}"


  # even or odd

  puts "pick a number "
  number = gets.chomp.to_i

  if number.even?
    puts " its even"
  else
    puts " its odd!"
  end

  puts number.even? ? "its even" : "its odd"


  message = number.even? ? " its even" : "its odd"

  puts message

  # hello.rb

  puts " Whate time is it ? ( hour ) ? "
  hour= gets.chomp.to_i

  if hour < 12
    puts "good morning"
  elsif > 19
    puts "Good evening"
  elsif hour >= 12
    puts " Good afternoon "
  end

  # OLD UI .RB

  puts " what do you want to do [read|write|exit]"
  action = gets.chomp.to_s

  if action == 'read'
    puts "Entering read mode..."
  elsif action == 'write'
    puts "Entering write mode..."
  elsif action == 'exit'
    puts "Goodbye!"
  else
    puts "Incorrect choice! "
  end

  # case statement

  case action

  when'read'
    puts "Entering read mode..."
  when'write'
    puts "Entering write mode..."
  when'exit'
    puts "Goodbye!"
  else
    puts "Incorrect choice! "
  end

  # bouliean logic
  # store.rb

  puts " Whate time is it ? ( hour ) ? "
  hour= gets.chomp.to_i

  #  condition ? code_if_truthy : code_if_false
  if hour >= 9 && hour <= 12 || hour >= 14 && hour <= 18
    puts "its open "
  else
    puts "its closed"
  end

  ## Version 2

  is_morning = hour >= 9 && hour <= 12
  is_afternoon = hour >= 14 && hour <= 18

  if is_afternoon || is_morning
    puts "its open "
  else
    puts "its closed"
  end

  ## Price is right

  computer_number = rand(5) #0 -> 4

  user_number = nil

  while user_number != computer_number # stop when false
    # until user_number == computer_number (stop when true)
    puts "can you guess"
    user_number = gets.chomp.to_i
  end

  or


  until user_number == computer_number # stop when false
    # until user_number == computer_number (stop when true)
    puts "can you guess"
    user_number = gets.chomp.to_i
  end

  puts "you WIN!!!"

  # FOR LOOPS

  # usful for definate leghts .. while when you don't know when to stop
  # finished at 59 mins on Thurday.
  number = [1,2,3]
  for num in numbers
    puts num
  end

  # empty_array [ ]
  # CRUD
  #
  # 1. Create << or push
  # 2. Read [index]
  # 3. Update [index] =
  # 4. Delte delete_at(index)
  #

  beatles = ["john", "ringo", "seb"]

  puts bealtes[2] # "seb"

  bealtes[2] = "paul"

  beatles[3] = "george"
  beatles << "george"
  beatles.push "george"

  beatles.length # lenght
  # https://docs.ruby-lang.org/en/2.3.0/Array.html?search=string+contains+a+word#method-i-include-3F
  beatles.insert

  p beatles # show all of an array
  beatles.delete("john")
  beatles.delete.at(2)
  beatles.last
  beatles[-1]

  beatles = ["John", "Ringo", "Paul", "George"]
  beatles.include?("John")   #=> true
  beatles.include?("Boris")   #=> false


  #methods over arrays

  beatles.each do |beatle|
    puts "#{beatle} is in the Beatles"
  end
  # or
  [1, 2, 3].each { |num| puts num }

  ### LOUCHY Example ###

  "hello, friend!!".split(/\b/)
  ["hello", ", ", "friend", "!!"]

  def vowel?(letter)
    %w[a e i o u].include? letter
  end

  def find_vowel_index(word)
    word.index(/[aeiou]/)
  end

  ### Create a method that louchebemizes a word
  # = “chat” should give “latchem”
  def louch_word(word)

    suffix = ["em", "é", "ji", "oc", "ic", "uche", "ès"]

    if word.length < 2
      word == word
    elsif if
      find_vowel_index(word) == 0
      word = "l#{word}#{suffix.sample}"
    end
    else
      first_vowel_index = find_vowel_index(word)
      beginning = word[0...first_vowel_index]
      ending = word[first_vowel_index...word.size]
      ## split(0, first_vowel_index)
      word = "l#{ending}#{beginning}#{suffix.sample}"
    end

    return word
  end

  def louchebemize(sentence)
    sentance_array = sentence.split(/\b/)
    louchy_arry = sentance_array.map do |word|
      if word =~ /\W+/
        word = word
      else
        louch_word(word)
      end
    end
    louchy_arry
    word = louchy_arry.join("")
  end
