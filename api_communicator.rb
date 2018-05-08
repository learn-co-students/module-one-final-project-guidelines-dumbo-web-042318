require 'rest-client'
require 'json'
require 'pry'

# class WeatherAPIGetter
  # url = api.openweathermap.org/data/2.5/forecast?q={city name},{country code}

  # BASE_URL= "api.openweathermap.org/data/2.5/forecast?q="

  def get_weather_data
    # puts "Which city would you like to view weather for? Please enter city."
    # city_name = gets.chomp.downcase
    # puts "Country code? Use us for United States"
    # country_code = gets.chomp.downcase
    # throw
    city_name = "paris"
    country_code = "fr"
    apikey = "304bcd251ded0521b8be10e3c5743f37"
    weather_json = RestClient.get("api.openweathermap.org/data/2.5/forecast?q=#{city_name},#{country_code}&APPID=#{apikey}")
    puts weather_hash = JSON.parse(weather_json)
  end

get_weather_data

  # def welcome_message
  #   puts "Hello! Welcome to WeatherCLI"
  #   puts "press w to get weather, press to q to exit"
  # end

  # def initialize
  #   welcome_message
  #   input = gets.chomp
  #   if input == "w"
  #     get_weather_data
  # end

# end
