require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  results = response_hash["results"].select {|info| info["name"] == character_name}

  arr_movies= results.first.select{|keys,value|keys == "films"}["films"]

  #COLLECT URLS 
  #PLUG INTO THE REST CLIENT TO GET INFO FOR THE MOVIES AND RETURN THE MOVIE HASHES 

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  #WILL TAKE IN THE MOVIE 

  titles = films.map do |film|
    response_string = RestClient.get(film)
    response_hash = JSON.parse(response_string)

    response_hash['title']
  end

  titles.each_with_index {|value, index| puts "#{index+1}. #{value}"}
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
