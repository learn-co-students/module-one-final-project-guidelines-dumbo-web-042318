
class WeatherCLI
  # def gimme_city # gets city from User
  #   puts "Which city would you like to view weather for? Please enter city."
  # end
  def initialize
    @instance_of_weatherapigetter = WeatherAPIGetter.new
  end

  def run
    welcome
    new_user = get_user_name
    city_name = get_city_name
    country_code = get_country_code
    @weekly_arr = get_forecast_from_api(city_name, country_code)

    create_and_save_forecast

    new_query = Query.create(city: city_name, country_code: country_code, user: new_user)
    a = Forecast.last

    new_query.update(forecast: a)

    display_result

  end

  def welcome
    puts "Hello! Welcome to WeatherCLI! Before we get to the weather:"
  end

  def get_user_name # gets user name
    puts "What is your name?"
    username = gets.chomp
    new_user = User.find_or_create_by(name: username)
    new_user
  end

  def get_city_name
    puts "Which city would you like to view weather for? Please enter city."
    city_name = gets.chomp
  end

  def get_country_code
    puts "Country code? Please enter country code as 2 characters **Use us for United States**"
    country_code = gets.chomp.downcase
  end

  def get_forecast_from_api(city_name, country_code)
    @instance_of_weatherapigetter.get_weather_forecast(city_name, country_code)
  end

  def create_and_save_forecast
    i = 0
    # while i < 5
      Forecast.create(temp: date_key_hash(i)["temp"], humidity: date_key_hash(i)["humidity"], date: date_key_hash(i)["date"])
      # i += 1
    # end
  end

  def date_key_hash(index)#cleanup?
    new_date = {}
    new_date["date"]= @weekly_arr[index]["dt_txt"]
    new_key = @weekly_arr[index]["main"]
    date_key_hash = new_key.merge(new_date)
  end

  def display_result
    puts "Hi #{User.last.name}, the temperature in #{Query.last.city} is #{Forecast.last.temp} F and the humidity level is #{Forecast.last.humidity}."
  end


 end
