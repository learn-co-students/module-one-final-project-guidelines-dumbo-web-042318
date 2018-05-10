
class WeatherAPIGetter

  def get_weather_forecast(city_name, country_code)
    @weather_hash = get_all_weather_data(city_name, country_code)
    weekly_arr
  end

  def weather_hash
    @weather_hash
  end

  # def create_and_save_forecast
  #   i = 0
  #   # while i < 5
  #     Forecast.create(temp: date_key_hash(i)["temp"], humidity: date_key_hash(i)["humidity"], date: date_key_hash(i)["date"])
  #     # i += 1
  #   # end
  # end
  #
  # def date_key_hash(index)#cleanup?
  #   new_date = {}
  #   new_date["date"]= weekly_arr[index]["dt_txt"]
  #   new_key = weekly_arr[index]["main"]
  #   date_key_hash = new_key.merge(new_date)
  # end

  def weekly_arr # 5 instances of hrly temp at 12pm
    weekly_arr=[]
    weekly_arr << weather_hash["list"][0]
    weather_hash["list"].each do |hourly|
     if  hourly["dt_txt"].include?("12:00:00")
        weekly_arr << hourly
     end
    end
    weekly_arr
  end

  # def get_weekly_arr(city_name, country_code)
  #   weather_hash = get_weather_data(city_name, country_code)
  #   create_weekly_arr(weather_hash)
  # end

  def get_all_weather_data(city_name, country_code) # gets info from API
    apikey = "304bcd251ded0521b8be10e3c5743f37"
    weather_json = RestClient.get("api.openweathermap.org/data/2.5/forecast?q=#{city_name},#{country_code}&APPID=#{apikey}&units=imperial")
    weather_hash = JSON.parse(weather_json)
  end


 end
