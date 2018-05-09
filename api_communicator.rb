require 'rest-client'
require 'json'
require 'pry'

#
class WeatherAPIGetter
#   url = api.openweathermap.org/data/2.5/forecast?q={city name},{country code}
#
#   BASE_URL= "api.openweathermap.org/data/2.5/forecast?q="

  def get_weather_data
    # puts "Which city would you like to view weather for? Please enter city."
    # city_name = gets.chomp.downcase
    # puts "Country code? Use us for United States"
    # country_code = gets.chomp.downcase
    # throw
    city_name = "paris"
    country_code = "fr"
    apikey = "304bcd251ded0521b8be10e3c5743f37"
    weather_json = RestClient.get("api.openweathermap.org/data/2.5/forecast?q=#{city_name},#{country_code}&APPID=#{apikey}&units=imperial")
    weather_hash = JSON.parse(weather_json)
  end

  def weekly_arr # 5 instances of hrly temp at 12pm
    weekly_arr=[]
    get_weather_data["list"].each do |hourly|
     if  hourly["dt_txt"].include?("12:00:00")
        weekly_arr << hourly
     end
    end
  end

  def date_key_hash(index)#cleanup?
    new_date = {}
    new_date["date"]=weekly_arr[index]["dt_txt"]
    new_key = weekly_arr[index]["main"]
    new_key.merge(new_date)
  end


  def create_weekly_forecast
    i = 0
    until i == 4
      Forecast.create(temp: date_key_hash(i)["temp"], humidity: date_key_hash(i)["humidity"], date: date_key_hash(i)["date"])
      i += 1
    end
  end



#   def hash_sanitizer
#     weather_hash = get_weather_data
#     new_hash = {}
#     weather_hash["list"][0]["main"].each do |info, value|
#       new_hash[info]= value
#         end
#     new_hash
#   end
# def weekly_arr
# weekly_arr = []
#   weather_hash["list"].each do |hourly|
#    if  hourly["dt_txt"].include?("12:00:00")
#       weekly_arr << hourly
#    end
#   end
# end
#
#   # def create_forecast
#   #   Forecast.create(temp: main_temp_arr["temp"], humidity: main_temp_arr["humidity"])
#   # end
#
  def welcome_message
    puts "Hello! Welcome to WeatherCLI"

    create_weekly_forecast
  end
#
  def initialize
    welcome_message
    # input = gets.chomp
    # if input == "w"
    #   get_weather_data
  end
#
 end
