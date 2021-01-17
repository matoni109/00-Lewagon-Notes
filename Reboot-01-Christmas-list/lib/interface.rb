# TODO: you can build your christmas list program here!
require_relative 'gift_methods'
require_relative 'days_till_christmas'
require_relative 'csv_methods'
require_relative 'etsy_scraper'
require 'date'
require 'csv'

puts "> Welcome to your Christmas gift list"
puts "---------- #{days_till_christmas} DAYS till Christmas -------"
filepath  = File.join(__dir__, 'gift_list.csv')
# Filepath now gives us this link path (starting from the Root directory on my computer):
# "/Users/paalringstad/code/twinturtle42/fullstack-challenges/01-Ruby/06-Parsing/Reboot-01-Christmas-list/lib/gift_list.csv"
# this means that it doesn't matter from which directory we execute our program, as it will always be able to identify our file
my_gift_list = []
load_csv(filepath, my_gift_list)

loop do
  puts "> Which action [list|add|delete|mark|idea|quit]?"
  print "> "
  answer = gets.chomp
  case answer
  when "list" then list(my_gift_list)
  when "add" then add_gift(my_gift_list)
  when "delete" then delete(my_gift_list)
  when "mark" then mark_as_purchased(my_gift_list)
  when "idea" then get_idea_from_etsy(my_gift_list)
  when "quit", "exit"
    save_csv(filepath, my_gift_list)
    break
  end
end
