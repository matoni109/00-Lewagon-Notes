# METHODS

i String#upcase

# https://www.foragoodstrftime.com/
# https://www.shortcutfoo.com/app/dojos/ruby-dates/cheatsheet

require 'date'
def days_to_xmas
  x_mas = DateTime.new(2020,12,25)
  x_mas.jd - Date.today.jd
end

xmas = Date.new(2020, 12, 25)
days_til_xmas = xmas.yday - Date.today.yday

Date.today.yday # $ day of the year
Date.today.nextyear # same date next year

(1..10).to_a  # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

@guesses = ["b", "a", "n"]
@word = "banana"

"hello, friend!!".split(/\b/)
["hello", ", ", "friend", "!!"]

#All guesses in @word?:
p @guesses.all?{|char| @word.include?(char)} #=> true
# All characters in @word are in @guesses:
p @word.chars.uniq.all?{|char| @guesses.include?(char)} #=> true

"hello".capitalize #=> "Hello"

"Hello, World".nil? #=> false

"hello".include?("lo")  #=> true

"hello".include?("z")   #=> false

"hello".upcase  #=> "HELLO"

"hello".downcase  #=> "HELLO"

"london".class #=> what is it ?

search.present?

16.remainder(5) #=> 1

16.divmod(5) #=> \[3, 1\]

15.0 / 4 #=> 3.75 float it

'4'.to_f #=> 4.0

'4'.to_i #=> 4

5.to_s        #=> "5"

nil.to_s      #=> ""

:symbol.to_s  #=> "symbol"
gsub("7", "l")          #=> "hello"

"Hello".downcase  #=> "hello"

"hello".empty?  #=> false

"".empty?       #=> true

4.even? #=> true

"hello".length  #=> 5

"hello".reverse  #=> "olleh"

"hello world".split  #=> ["hello", "world"]

"hello".split("")    #=> ["h", "e", "l", "l", "o"]

" hello, world   ".strip  #=> "hello, world"

"he77o".sub("7", "l")           #=> "hel7o"

"he77o".gsub("7", "l")          #=> "hello"

@iban.gsub(/(?<=\A.{4})(.\d{4}){4}(.\w{4}.)/, '*******')
# "FR14*******606"

"helloo!!'-".delete("!'-")      #=> "helloo"

"hello".insert(-1, " dude")     #=> "hello dude"

"hello".split("")               #=> ["h", "e", "l", "l", "o"]

"!".prepend("hello, ", "world") #=> "hello, world!"


"All you need is code".split      #=> ["All", "you", "need", "is", "code"]

# equivalent to
"All you need is code".split(" ") #=> ["All", "you", "need", "is", "code"]

# you can specify the separator as an argument...
"boris@lewagon.org".split("@")    #=> ["boris", "lewagon.org"]

# ... if it's an empty string #split will return an array of characters
"boris".split("")                 #=> ["b", "o", "r", "i", "s"]

# https://docs.ruby-lang.org/en/2.3.0/Date.html

String like "Hello World"

Integer like 12

Float like 3.14

Array like ["Hello World", 12, 3.14]

TrueClass like true

FalseClass like false

Range like (1..100)
