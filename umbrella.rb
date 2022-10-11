p "Hi! Where are you located?"

user_location = gets.chomp

p user_location

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyAgRzRHJZf-uoevSnYDTf08or8QFS_fb3U"

require "open-uri"
raw_data = URI.open(gmaps_url).read

require "json"
parsed_data = JSON.parse(raw_data)

lat_long_hash = parsed_data["results"][0]["geometry"]["location"]

latitude = lat_long_hash["lat"]
longitude = lat_long_hash["lng"]

p latitude
p longitude
