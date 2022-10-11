p "Hi! Where are you located?"

user_location = gets.chomp

p user_location

gmaps_token = ENV.fetch("GMAPS_TOKEN")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_token}"

require "open-uri"
raw_data = URI.open(gmaps_url).read

require "json"
parsed_data = JSON.parse(raw_data)

lat_long_hash = parsed_data["results"][0]["geometry"]["location"]

latitude = lat_long_hash["lat"]
longitude = lat_long_hash["lng"]

p latitude
p longitude

dark_sky_token = ENV.fetch("DARK_SKY_TOKEN")

dark_sky_url = "https://api.darksky.net/forecast/#{dark_sky_token}/#{latitude},#{longitude}"

data_sky = URI.open(dark_sky_url).read
parsed_sky_data = JSON.parse(data_sky)

weather_now = parsed_sky_data["currently"]

temp_now = weather_now["temperature"]
summary_now = weather_now["summary"]

p "Currently, the temperature is #{temp_now} and there is #{summary_now}"
