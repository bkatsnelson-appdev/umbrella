puts "=========================="
puts "WILL YOU NEED AN UMBRELLA TODAY?" 
puts "=========================="
puts " "

p "Hi! Where are you located?"

user_location = gets.chomp

p "Checking the weather at #{user_location}..."

gmaps_token = ENV.fetch("GMAPS_TOKEN")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_token}"

require "open-uri"
raw_data = URI.open(gmaps_url).read

require "json"
parsed_data = JSON.parse(raw_data)

lat_long_hash = parsed_data["results"][0]["geometry"]["location"]

latitude = lat_long_hash["lat"]
longitude = lat_long_hash["lng"]

p "Your coordinates are #{latitude}, #{longitude}."

dark_sky_token = ENV.fetch("DARK_SKY_TOKEN")

dark_sky_url = "https://api.darksky.net/forecast/#{dark_sky_token}/#{latitude},#{longitude}"

data_sky = URI.open(dark_sky_url).read
parsed_sky_data = JSON.parse(data_sky)

weather_now = parsed_sky_data["currently"]

temp_now = weather_now["temperature"]
summary_now = weather_now["summary"]

p "It is currently #{temp_now.to_i} degrees F"
p "Next hour: #{summary_now.capitalize} for the hour."

hourly_data = parsed_sky_data["hourly"]["data"]

rain = 0
12.times do |index|
  rain_prob = hourly_data[index]["precipProbability"]
  if rain_prob > 0.1
    rain = rain + 1
    p "In #{index} hours, there is a #{(rain_prob.to_f * 100.0).to_i}% chance of precipitation."
  end
end

if rain > 0
  p "You might want to carry an umbrella!"
else
  p "You probably won't need an umbrella today."
end
