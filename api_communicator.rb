
class WeatherAPIGetter
  # def gimme_city # gets city from User
  #   puts "Which city would you like to view weather for? Please enter city."
  # end

  def self.weather_hash_reader
    @@weather_hash
  end

  def self.weather_hash=(x)
    @@weather_hash = x
  end

  def self.city_name
    a = gets.chomp.downcase
    # binding.pry
    a
  end

  def self.gimme_cc # gets country code
     a = gets.chomp.downcase
     a
  end

  def self.get_user_name # gets user name
    username = gets.chomp
    username
  end

  def self.city
    @@city
  end

  def self.city=(x)
    @@city = x
  end

  def self.country_code
    @@country_code
  end

  def self.country_code=(x)
    @@country_code = x
  end


  def self.get_weather_data # gets info from API

    puts "Which city would you like to view weather for? Please enter city."
    self.city= self.city_name

    puts "Country code? Please enter country code as 2 characters **Use us for United States**"
    self.country_code = self.gimme_cc


    apikey = "304bcd251ded0521b8be10e3c5743f37"
    weather_json = RestClient.get("api.openweathermap.org/data/2.5/forecast?q=#{self.city},#{self.country_code}&APPID=#{apikey}&units=imperial")
    self.weather_hash=(JSON.parse(weather_json))

  end

  def self.weekly_arr # 5 instances of hrly temp at 12pm
    weekly_arr=[]
    weekly_arr << weather_hash_reader["list"][0]
    weather_hash_reader["list"].each do |hourly|
     if  hourly["dt_txt"].include?("12:00:00")
        weekly_arr << hourly
     end
    end
    weekly_arr
  end

  def self.date_key_hash(index)#cleanup?
    new_date = {}
    new_date["date"]=weekly_arr[index]["dt_txt"]
    new_key = weekly_arr[index]["main"]
    new_key.merge(new_date)
  end


  def self.create_weekly_forecast
    i = 0
    # while i < 5
      Forecast.create(temp: date_key_hash(i)["temp"], humidity: date_key_hash(i)["humidity"], date: date_key_hash(i)["date"])
      # i += 1
    # end
  end

  def self.welcome
    puts "Hello! Welcome to WeatherCLI! Before we get to the weather:"
    puts "What is your name?"
    username = self.get_user_name
    new_user = User.create(name: username)
    self.get_weather_data

    Query.create(city: city, country_code: country_code, user: new_user)

    a = self.create_weekly_forecast
    Query.last.update(forecast: a)
    binding.pry
    true
  end


 end
