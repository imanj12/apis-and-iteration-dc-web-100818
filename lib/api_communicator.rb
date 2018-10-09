require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  films_array = []
  response_hash["results"].each do |char|
    if char["name"].downcase == character
      films_array = char["films"]
    end
  end

  film_hashes = []
  films_array.each do |url|
    dirty_hash = RestClient.get(url)
    film_hash = JSON.parse(dirty_hash)
    film_hashes << film_hash
  end

  film_hashes

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def print_movies(film_hashes)
  # some iteration magic and puts out the movies in a nice list
  film_hashes.each do |hash|
    puts hash["title"]
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
