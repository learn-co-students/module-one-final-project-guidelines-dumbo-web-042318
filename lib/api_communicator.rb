
class WeatherAPIGetter

  def get_weather_forecast(city_name, country_code)
    @weather_hash = get_all_weather_data(city_name, country_code)
    weekly_arr
  end

  def weather_hash
    @weather_hash
  end

  def calculating_difference
    lon = (weather_hash["city"]["coord"]["lon"]).abs
    x = ((lon / 15) + 12).to_i

    if x > 24
      x = x - 24
    end

    case x
    when (1..4)
      time = "03:00:00"
    when (5..7)
      time = "06:00:00"
    when (8..10)
      time = "09:00:00"
    when (11..13)
      time = "12:00:00"
    when (14..16)
      time = "15:00:00"
    when (17..19)
      time = "18:00:00"
    when (20..22)
      time = "21:00:00"
    else
      time = "00:00:00"
    end

  end

  def weekly_arr # 5 instances of hrly temp at 12pm
    x = calculating_difference
    weekly_arr=[]
    # weekly_arr << weather_hash["list"][0]
    weather_hash["list"].each do |hourly|
     if hourly["dt_txt"].include?(x) || hourly["dt_txt"].include?("00:00:00")
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
