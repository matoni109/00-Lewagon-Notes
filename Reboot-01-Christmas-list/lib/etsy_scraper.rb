require 'nokogiri'
require 'open-uri'
require_relative 'gift_methods'

# As we don't want to be banned from Etsy, created first a method that stores
# the HTML into a file called etsy.html
def get_html_file
  puts "What are you looking for on Etsy?"
  print "> "
  item = gets.chomp
  url = "https://www.etsy.com/au/search?q=#{item}"
  html_file = open(url).read
end

def parse_html(html_file)
  doc = Nokogiri::HTML(html_file)
  etsy_gift_ideas = []
  counter = 0
  max_results = 10
  doc.search('.v2-listing-card .v2-listing-card__info .text-body').each_with_index do |node, index|
    if node.text.strip.length < 50 && counter < max_results
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

def get_idea_from_etsy(my_gift_list)
  html_file = get_html_file
  etsy_gift_ideas = parse_html(html_file)
  display_results(etsy_gift_ideas)
  puts "> Which item do you want to add"
  # Get user input
  index = gets.chomp.to_i - 1
  gift_idea = etsy_gift_ideas[0]
  my_gift_list << {gift_name: gift_idea, purchased: false}
end



