#https://blog.marahin.pl/ruby-array-to-hash-74fd7501b011
#https://ruby-doc.org/core-2.7.2/Hash.html
# https://blog.marahin.pl/ruby-array-to-hash-74fd7501b011

boris = { first_name: "Boris", github_nickname: "Papillard" }

boris.each_value do |value|
  puts "#{value} is an attribute of boris"
end

# boris.each_value do |value|
# boris.each_key do |key|

newhash = Hash.new(0)

#example array to hash
#a
t2 = [[1, 2], [3, 4]].map{|x| [x, x]}
Hash[t2] # => {1=>2, 2=>4, 3=>6, 4=>8}
#b
t2 = [[1, 2], [3, 4]].map{|x| [x[0], x[1]]}
#=> [[1, 2], [3, 4]]

#Example 2
received_data = [{ 'USD' => '1', 'PLN' => '4.23'}]
Hash[* received_data.map(&:values).flatten]
#=> {"USD"=>"1", "PLN"=>"4.23"}

#Example 3
 hash = Hash[array.collect.with_index { |item, index| ["key#{index}", "#{item[0]}"] }]

## HASH ME ##
#
word_count = Hash.new(0)

students_age = {
  "Peter" => 24,
  "Mary" => 25,
  "George" => 22,
  "Emma" => 20
}

# CRUD
# Students = ["pual", "john"]
# C: students << "george"
# R: students[1]
# U: students[1] = "ringo"
# D: students.delete_at(1)

# HasH
#
paris = {
  "country" => "France",
  "population" => 2211000,
    "people" => ["pieree", "marrie"]
}


# Create / Update
paris["monument"] = "Eiffel Tower"
paris["star_monument"] = "Tour Eiffel"
#          key       vaulue
puts paris
# Read
puts paris ["population"]
#                 key
# Destroy
paris.delete("population")

paris.each do |key, value|
  puts "Paris #{key} is #{value}"
end

paris["people"].each do |parisian|
  puts parisian
end

# has only methods for HASH
paris.key?("country")   #=> true
paris.key?("language")  #=> false
paris.keys              #=> ["country", "population", "star_monument"]
paris.values            #=> ["France", 2211000, "Tour Eiffel"]
paris.has_value?        # true
paris.has_key?("monument")


students = {
  "paul" => 24,
  "mary" => 24,
  "john" => 25
}

students.count do |record|
    name = record[0]
    age = record[1]
    age ==24
end

#SYMBOLS :

paris = {
  :country => "France",
  :population => 2211000
}

paris = {
  country: "France",
  population: 2211000
}

# New syntax does not change the way we read a key
puts paris[:population]
# https://stackoverflow.com/questions/16621073/when-to-use-symbols-instead-of-strings-in-ruby/16621092#16621092


# example 1
tag("h1", "Hello world")
# => <h1>Hello world</h1>

tag("h1", "Hello world", { class: "bold" })
# => <h1 class='bold'>Hello world</h1>

tag("a", "Le Wagon", { href: "http://lewagon.org", class: "btn" })
# => <a href='http://lewagon.org' class='btn'>Le Wagon</a>
def tag(name, content, attrs = {})
  flat_attrs = attrs.map { |key, val| " #{key}='#{val}'" }.join
  return "<#{name}#{flat_attrs}>#{content}</#{name}>"
end

#DATA FORMAT
# file.csv
# Paris,2211000,"Tour Eiffel"
# London,8308000,"Big Ben"

require "csv"

CSV.foreach("file.csv") do |row|
  # row is an array. For first iteration:
  # row[0] is "Paris"
  # row[1] is 2211000, etc.
  puts "#{row[0]} population is #{row[1]}, its famous for #{row[3]}"
end

#JSON / HASH

{
  "name": "Paris",
  "population": 2211000
}

require "json"
JSON.parse('{ "name": "Paris", "population": 2211000 }')
# => { "name" => "Paris", "population" => 2211000 }


require "json"
require "open-uri"

puts "What's your github nickname?"
nickname = gets.chomp

#API Call
json = open("https://api.github.com/users/#{nickname}").read

# json is a string from the internets
user = JSON.parse.(json)
# user as a Hash

puts "Hi #{user[user["name"]]}, yor id is #{user[id]}"

# makes a compare of 2 hashes.
  #code from stack
  letter_count = grid_check.each_with_object(Hash.new(0)){ |item, hash| hash[item] += 1 }
  attempt_count = attempt.upcase.split("").each_with_object(Hash.new(0)){ |item, hash| hash[item] += 1 }
  # end code from stack

=> {"S"=>1, "P"=>1, "E"=>1, "L"=>2}
[78] pry(main)> count
=> 0
[79] pry(main)> b
=> {"S"=>1, "P"=>1, "E"=>1, "L"=>1, "O"=>4}

  game_hash[:time] = end_time - start_time

  if word_hash["found"] == true && check.chars.uniq.all?{|char| grid_check.include?(char)} == true
  game_hash[:score] = ( attempt.length * 1.5 ) + ( 99 - game_hash[:time])
  game_hash[:message] = "well done"
   count = 0

    attempt_count.each_pair do |key, value|
    if  attempt_count[key] > letter_count[key]
      count += 1
      end
      count > 0 ? game_hash[:score] = 0 : "its odd"
      count > 0 ? game_hash[:message] = "not in the grid" : "its odd"
    end

  end
