require 'rest-client'
require 'json'
require 'pry'

class WeatherAPIGetter
  # url = api.openweathermap.org/data/2.5/forecast?q={city name},{country code}

  BASE_URL= "api.openweathermap.org/data/2.5/forecast?q="

  def get_weather_data
    city_name = "Paris"
    country_code = "fr"
    apikey = "304bcd251ded0521b8be10e3c5743f37"
    weather_json = RestClient.get("api.openweathermap.org/data/2.5/forecast?q=#{city_name},#{country_code}&APPID=#{apikey}")
    puts weather_hash = JSON.parse(weather_json)
  end

  def welcome_message
    puts "Hello! Welcome to WeatherCLI"
    puts "press h for help"
    puts "Here's how to use this program:"
    puts "press w to get weather"
    puts "press q to quit"
  end

  def initialize
    welcome_message

  end

end
