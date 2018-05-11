
class WeatherAPIGetter

  def get_weather_forecast(city_name, country_code)#grabs info from our api for our location and country
    @weather_hash = get_all_weather_data(city_name, country_code)
    weekly_arr
  end

  def weather_hash
    @weather_hash
  end

  def calculating_difference #gives approx difference from UTC time and adjusts our locations time
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

  def weekly_arr # returns 5 instances of hrly temp at 12pm
    x = calculating_difference
    weekly_arr=[]

    if x == "03:00:00" || x == "06:00:00" || x == "09:00:00" || x == "12:00:00"
      #if we are past noon prog was returning only 4 days(tmrw at noon onward)
      weekly_arr << weather_hash["list"][0]
    end
    weather_hash["list"].each do |hourly|
      #grabs our hourly datetime and compares to see if it is noon. adds noon to our array
     if hourly["dt_txt"].include?(x)
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
