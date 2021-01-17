# reular expressions
# https://ruby-doc.org/core-2.7.2/Regexp.html
# https://regex101.com
# https://rubular.com/
# https://regexr.com
#
# https://github.com/K-and-R/email_validator
#
# https://debuggex.com
#REGEX for webstite
#  ^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$
# UK Phone
/^\+\d{2}\s\d{2}\s\d{4}\s\d{4}$/
# start and end with /  /

# .include?
# Delimiters
/.../

# Basics
/a/ # a
/ab/ # ab
\s? # " " or "" space or not

# Quantifiers
/abc?/     # ab followed by 0..1 c
/abc*/     # ab followed by 0..∞ c # use for a space
/abc+/     # ab followed by 1..∞ c
/abc{3}/   # ab followed by 3 c
/abc{3,}/   # ab followed by 3 cccccc => ∞
/abc{3,5}/   # ab followed by 3 ccccc => 5

# Example 1 match below
+44 20 7946 0234
+442079460234

/\+[0-9]{2}\s?[0-9]{2}\s?[0-9]{4}\s?[0-9]{4}/
could enforce with
^   $ at each end

# french post code can use |
# 5 x digits or 2AB and 3 digits
/\d{5}|2[AB]\d{3}/

# Grouping

/(abc)+/      # 1..∞ abc
/(a|b)c/      # ac OR bc

# Ranges
/./           # any character
/[aB9]/       # a OR B OR 9
/[0-9]/       # any numeric character
/[a-zA-Z]/    # any alphabetical character
/[^a-c]/      # any char BUT a, b OR c

/\Aabc/  # any abc pattern found at the beginning of a string
/abc\z/  # any abc pattern found at the end of a string
/\d/          # like /[0-9]/
/\w/          # like /[a-zA-Z0-9_]/
/\W/          # like /[^a-zA-Z0-9_]/
/\s/          # whitespace (space, tab, line-break, ...)
/\bis/        # only matchs is as a string alone

# ANCHORS
/^abc/        # starts with abc
/abc$/        # ends with abc
/^abc$/       # contains only abc
/\b/          # word boundary (start or end of word)

# Modifiers
/hello/i          # Will match hello, Hello, HeLlO, HELLO, ...
/hello.world/m    # Will match hello\nworld

# REGEX Class in Ruby

"hello" =~ /l{2}/       #=> 2
"hello" =~ /m{2}/       #=> nil

"hello".match?(/l{2}/)  #=> true
"hello".match?(/m{2}/)  #=> false

text = "
this is a multi-line text
try to match only this line
and not the others
"

text =~ /^try .* line$/       #=> 27 -> The **position** of the match
text =~ /\Atry .* line\z/     #=> nil
#end @ 54 mins

#MATCH

match_data = "John Doe".match(/^(\w+) (\w+)$/)
puts "Firstname: #{match_data[1]}"
puts "Lastname: #{match_data[2]}"
# => Firstname: John
# => Lastname: Doe

pattern = /^(?<first_name>\w+) (?<last_name>\w+)$/

match_data = "John Doe".match(pattern)
puts match_data[:first_name]
puts match_data[:last_name]

# GSUB

"hello guys".gsub(/g.{3}/, 'le wagon')
#=> "hello le wagon"

"hello guys".gsub(/^(\w+) (\w+)$/, 'Oh \2, \1!')
#=> "Oh guys, hello!"

#SCAN ( returns an array )
"Let's play tic tac toe".scan(/t../)
#=> ["t's", "tic", "tac", "toe"]

"Let's play tic tac toe".scan(/\bt../)
#=> ["tic", "tac", "toe"]
