require 'nokogiri'
require_relative 'gift_methods'

# As we don't want to be banned from Etsy, created first a method that stores
# the HTML into a file called etsy.html
def scrape_etsy
  puts "What are you looking for on Etsy?"
  print "> "
  item = gets.chomp
  url = "https://www.etsy.com/au/search?q=#{item}"
  file_path = "etsy.html"
  system("curl #{url} > #{file_path}")
  #CURL # stands for Client URL
  #curl is a command line tool to transfer data to or from a server
  #system allows us to execute a terminal command in text editor
  #This method allows us to get data from a website and store it into a file called "etsy.html"
end

# This next method, is just to get an "X" number of search results
def parse_html(file_path)
  html_file = File.open(file_path)
  doc = Nokogiri::HTML(html_file)
  etsy_gift_ideas = [] # create an array to store etsy_gift_ideas
  counter = 0 # create a counter as I only want 10 results in total...
  max_results = 10
  doc.search('.v2-listing-card .v2-listing-card__info .text-body').each_with_index do |node, index|
    if node.text.strip.length < 50 && counter < max_results
    # if you remove the first condition (node.text.strip.length < 50)
    # We'll get some very long words. And create a counter to only get 10 results
    # you can remove the if condition and see what you return elsewise
      # puts "#{counter} - #{node.text.strip}"
      etsy_gift_ideas << node.text.strip
      counter += 1
    end
  end
  return etsy_gift_ideas
end

def display_results(etsy_gift_ideas)
  etsy_gift_ideas.each_with_index do |gift_idea, index|
    puts "#{index + 1} - #{gift_idea}"
  end
end

# this method calls all the above methods to respectively:
# 1) Scrape etsy
# 2) Parse the HTML doc
# 3) Display the results
# 4) Return the result and store in into a the gift_list array in the interface

def get_idea_from_etsy(my_gift_list)
  scrape_etsy
  etsy_gift_ideas = parse_html("etsy.html")
  display_results(etsy_gift_ideas)
  puts "> Which item do you want to add"
  # Get user input
  index = gets.chomp.to_i - 1
  gift_idea = etsy_gift_ideas[0]
  my_gift_list << {gift_name: gift_idea, purchased: false}
end






