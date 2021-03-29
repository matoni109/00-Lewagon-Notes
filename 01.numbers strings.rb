# Addition
1 + 1   #=> 2

 user["email"]&.split(' ')

# Subtraction
2 - 1   #=> 1

# Multiplication
2 * 2   #=> 4

# Division
10 / 5  #=> 2

# Exponent
2 ** 2  #=> 4
3 ** 4  #=> 81

# Modulus (find the remainder of division)
8 % 2   #=> 0  (8 / 2 = 4; no remainder)
10 % 4  #=> 2  (10 / 4 = 2 with a remainder of 2)

17 / 5    #=> 3, not 3.4

17 / 5.0  #=> 3.4

# euclidean division
12 / 5               #=> 2
(12 / 5).class       #=> Integer

# decimal division
12.fdiv(5)           #=> 2.4
(12.fdiv(5)).class   #=> Float


# To convert an integer to a float:
13.to_f   #=> 13.0

# To convert a float to an integer:
13.0.to_i #=> 13
13.9.to_i #=> 13

# To convert a float to an integer:
11.8.floor #=> 11
13.9.ceil #=> 14

3.1416.truncate #=> 3

sprintf("%.2f", 5)
=> "5.00"

6.even? #=> true
7.even? #=> false

6.odd? #=> false
7.odd? #=> true

# With the plus operator:
"Welcome " + "to " + "Odin!"    #=> "Welcome to Odin!"

# With the shovel operator:
"Welcome " << "to " << "Odin!"  #=> "Welcome to Odin!"

# With the concat method:
"Welcome ".concat("to ").concat("Odin!")  #=> "Welcome to Odin!"

"hello"[0]      #=> "h"

"hello"[0..1]   #=> "he"

"hello"[0, 4]   #=> "hell"

"hello"[-1]     #=> "o"

/\  #=> Need a backslash in your string?
\b  #=> Backspace
\r  #=> Carriage return, for those of you that love typewriters
\n  #=> Newline. You'll likely use this one the most.
\s  #=> Space
\t  #=> Tab
\"  #=> Double quotation mark
\'  #=> Single quotation mark

puts "Hello \n\nHello"
Hello

Hello
=> nil

name = "Odin"

puts "Hello, #{name}" #=> "Hello, Odin"
puts 'Hello, #{name}' #=> "Hello, #{name}"

rb :001 > 4 == 4 #=> true

irb :002 > 4 == 5  # => false
