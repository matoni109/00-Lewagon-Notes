#CSV

"Name","Appearance","Origin"
"Edelweiss","White","Austria"
"Cuvée des Trolls","Blond","Belgium"
"Choulette Ambrée","Amber","France"
"Gulden Draak","Dark","Belgium"

# XML means eXtensible Markup Language

<?xml version="1.0" encoding="UTF-8"?>
<beers>
<title>Great beers</title>
<beer>
<name>Edelweiss</name>
<appearance>White</appearance>
<origin>Austria</origin>
</beer>
<beer>
<name>Cuvée des Trolls</name>
<appearance>Blond</appearance>
<origin>Belgium</origin>
</beer>
...
  </beers>


# JSON
# JavaScript Object Notation

# Filename: beers.json

{
  "title": "Great beers",
  "beers": [
    {
      "name": "Edelweiss",
      "appearance": "White",
      "origin": "Austria"
    },
    {
      "name": "Cuvée des Trolls",
      "appearance": "Blond",
      "origin": "Belgium"
    },

  ]
}

#CSV READING

require 'csv'

filepath = 'beers.csv'
i = 0

CSV.foreach(filepath) do |row|
  # Here, row is an array of columns

  if i > 0
    name = row[0]
    appearacne = row[1]
    origin = row[2]
    puts name
  end

  puts "#{row[0]} | #{row[1]} | #{row[2]}"

  i += 1
end

# READING CSV 2

def load_csv(csv_filepath)
  CSV.foreach(csv_filepath) do |row|
    recipe = Recipe.new(row[0], row[1])
    # turning instances into an array
    @recipes << recipe
  end
end

# Parsing CSV (2)

# If your file has headers

require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'beers.csv'
# CSV will return a HASH format
CSV.foreach(filepath, csv_options) do |row|
  puts "#{row['Name']}, a #{row['Appearance']} beer from #{row['Origin']}"
end

# example read and =. array 2
def load_csv(filepath, my_gift_list)
  CSV.foreach(filepath) do |row|
    gift_hash = {}
    gift_hash[:gift_name] = row[0]
    #-----bug to fix-------
    # def true?(obj)
    #   obj.to_s.downcase == "true"
    # end
    gift_hash[:purchased] = false
    # Convert the each array into a hash
    my_gift_list << gift_hash
  end
end

# example of read 2

def load_csv(csv_filepath)
  CSV.foreach(csv_filepath) do |row|
    # binding.pry
    p post = Post.new(row[0], row[1], row[2], row[3], row[4])
    # Convert the each array into a hash
    @posts << post
  end
end

# Storing CSV

require 'csv'

csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
filepath    = 'beers.csv'

beers = [
  { name: 'Asahi', appearance: 'Pale Lager', origin: 'japan'}
]

CSV.open(filepath, 'wb', csv_options) do |csv|

  # csv << ['Asahi', 'Pale Lager', 'Japan']
  # csv << ['Guinness', 'Stout', 'Ireland']
  # ...
  # beers is an array of Hashes
  #
  beers.each do |beer|
    csv << [beer[:name], beer[:Appearance], beer[:Origin]]
  end

end

#Example of CSV Storing
def add_recipe(recipe) # task parameter is a task instance
  @recipes << recipe

  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

  CSV.open(@csv_filepath, 'wb', csv_options) do |csv|
    @recipes.each do |recipe|
      p recipe.name
      csv << [recipe.name, recipe.description]
    end
  end
end

#Example 2  of CSV Storing as a REPO of instance VARS

def save_csv
  CSV.open(@csv, 'wb') do |row|
    row << %w(id, name, price)
    @meals.each do |meal|
      row << [meal.id, meal.name, meal.price]
    end
  end
end

# READING JASON use .parse
require 'json'

url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
word_back = open(url).read
p word = JSON.parse(word_back)

# Example 2

require 'json'

filepath = 'beers.json'

serialized_beers = File.read(filepath)

beers = JSON.parse(serialized_beers)

# beers is a ruby Hash
puts beers["beers"]


require 'json'

beers = { beers: [
            {
              name:       'Edelweiss',
              appearance: 'White',
              origin:     'Austria'
            },
            {
              name:       'Guinness',
              appearance: 'Stout',
              origin:     'Ireland'
            },
]}

puts json_file["beers"][1]["name"]
#
#       Array
#                  Hash
# is it a hash or an array ?
#
# TODO: Display all the origins
#
json_file["beers"].each do |beer|
  # beers is a hash
  puts beer["origin"]
end

# Examle 2
# TODO: Display all the unique origins
#
origins = []
json_file["beers"].each do |beer|
  # beers is a hash
  # put them in a array
  origins << beer["origin"]
end

p origins.uniq.sort  # <---- Nice



# PARSING / STORING JSON => use .generate

require 'json'

beers = { beers: [
            {
              name:       'Edelweiss',
              appearance: 'White',
              origin:     'Austria'
            },
            {
              name:       'Guinness',
              appearance: 'Stout',
              origin:     'Ireland'
            },
]}

File.open(filepath, 'wb') do |file|
  file.write(JSON.generate(beers))
end

# Example 1

require 'json'

students = ["paul", "john"]

JSON.generate(students)
#=> "[\"pual\",\"john\"]"

# accessing API'S

# https://api.github.com/orgs/lewagon/repos
# USE extension JSON VIEW
#
require 'json'
require 'open-uri'

url = 'https://api.github.com/users/ssaunier'
user_serialized = open(url).read # is a string
user = JSON.parse(user_serialized) # user is a HASH

puts "#{user['name']} - #{user['bio']}"




#SCRAPING
# pick the class and scrap that
.the_class

<div class="the_class">
Some text
</div>

# div is tag selector.
# .the_class is a Class selector.
# #the_id is an ID selector.


require 'open-uri'
require 'nokogiri'

ingredient = 'chocolate'
url = "https://www.bbcgoodfood.com/search/recipes?q=#{ingredient}"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.standard-card-new__article-title').each do |element|
  puts element.text.strip
  puts element.attribute('href').value
end

Happy scraping


# TODO: Write a seed to insert 100 posts in the database
puts 'Creating 10 fake posts...'

url = 'https://hacker-news.firebaseio.com/v0/topstories.json'
id_of_posts = open(url).read
post2 = JSON.parse(id_of_posts).take(10)

response = RestClient.get "https://hacker-news.firebaseio.com/v0/item/25146610.json"
repos = JSON.parse(response)

post2.each do |element|
  response = RestClient.get "https://hacker-news.firebaseio.com/v0/item/#{element}.json"
  repos = JSON.parse(response)
  post1 = Post.new(
    title:    repos["title"],
    url: repos["url"],
    votes:  repos["score"]
  )
  post1.save
end
