
class WeatherAPIGetter

  def get_weather_forecast(city_name, country_code)
    @weather_hash = get_all_weather_data(city_name, country_code)
    weekly_arr
  end

  def weather_hash
    @weather_hash
  end

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


  def get_all_weather_data(city_name, country_code) # gets info from API
    apikey = "304bcd251ded0521b8be10e3c5743f37"
    link = "api.openweathermap.org/data/2.5/forecast?q=#{city_name},#{country_code}&APPID=#{apikey}&units=imperial"
    response = RestClient.get(link)
    JSON.parse(response)
  end

 end
