
def weekly_arr # 5 instances of hrly temp at 12pm
weekly_arr = []
  weather_hash["list"].each do |hourly|
   if  hourly["dt_txt"].include?("12:00:00")
      weekly_arr << hourly
   end
  end
end

def main_temps # grabs "main" hash from weekly_arr
 main_temp_arr = weekly_arr.map.with_index do |n, i|
   weekly_arr[i]["main"]
 end
end

def grab_temps # grabs all 5 temps from main_temps
  main_temps.map do |hash|
    p hash["temp"]
  end
end

# def find_one_temp(date) # need to throw exceptions
#   hash_sanitizer.each do |hash|
#    if hash["dt_txt"].include?(date)
#      return hash["main"]["temp"]
#    end
#   end
# end

def date_key_hash(INDEX)#cleanup?
  new_date = {}
  new_date["date"]=hash_sanitizer[INDEX]["dt_txt"]
  new_key = hash_sanitizer[INDEX]["main"]
  new_key.merge(new_date)
end

def find_dynamic_from_hash(date_hash)

end

def weekly_forecast
  i = 0
  until i == 4
    Forecast.create(temp: date_key_hash(i)["temp"], humidity: date_key_hash(i)["humidity"], date: date_key_hash(i)["date"])
    i += 1
  end
end


Forecast.create(temp: date_key_hash(index)["temp"], humidity: date_key_hash(index)["humidity"], date: date_key_hash(index)["date"])

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
