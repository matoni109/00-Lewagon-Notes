#Get the links of the first 10 movies
require 'open-uri'
require 'nokogiri'
require 'yaml'


def get_links
  url = "https://www.imdb.com/chart/top"
  #Open uri will get the information of the page
  html_file = open(url, "Accept-Language" => "en").read
  #Transform the html file in something Ruby-readable
  html_doc = Nokogiri::HTML(html_file)
  #Take the A attribute inside the titleColumn class
  html_doc.search('.titleColumn a').take(10).map do |element|
    #"/title/tt0120737/"
    link_partial = element.attributes['href'].value
    "https://www.imdb.com#{link_partial}"
  end
  #return an array with 10 links
end


def get_movie_information(link)

  #lik is the url to scrape
  html_file = open(link, "Accept-Language" => "en").read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.text
  movie = {}
  # title: "The Shawshank Redemption"
  # year: 1994
  html_doc.text
  title = html_doc.search('.title_wrapper h1').first.text.strip
  match_results = title.match(/(?<title>.+)\((?<year>\d{4})/)
  movie[:title] = match_results[:title]
  movie[:year] = match_results[:year]
  #storyline
  storyline = html_doc.search('.summary_text').first.text.strip
  movie[:storyline] = storyline
  #Director
  director = html_doc.search('h4:contains("Director:") + a').first&.text.strip
  movie[:director] = director
  #cast
  cast = html_doc.search('.primary_photo + td a').take(3).map { |link| link.text.strip }
  movie[:cast] = cast
  movie
end


#Or every link, visit the movie page and scrape the informations
get_links.map do |link|
  get_movie_information(link)
end

File.open('movies.yml', 'wb') do |file|
  p movie_array.to_yaml
  file.write(movie_array.to_yaml)
end

# Example 2

require 'csv'

def most_successful(number, max_year, file_path)
  my_movie_list = []

  # TODO: return the `number` of most successful movies before `max_year`
  CSV.foreach(file_path) do |row|
    movie_hash = {}
    movie_hash[:name] = row[0]
    movie_hash[:year] = row[1].to_i
    movie_hash[:earnings] = row[2].to_i #== "true") #solution 1
    if movie_hash[:year] < max_year
      my_movie_list << movie_hash
    end
  end

  sorted_movies = my_movie_list.sort_by! { |row| row[:earnings] }.reverse

  p sorted_movies.first(number)
end
