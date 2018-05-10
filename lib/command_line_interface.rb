
class WeatherCLI

  def initialize
    @instance_of_weatherapigetter = WeatherAPIGetter.new
  end

  def run
    welcome
    new_user = get_user_name
    city_name = get_city_name
    country_code = get_country_code
    begin
    @weekly_arr = get_forecast_from_api(city_name, country_code)
    rescue
      puts "Oops. Try again."
      city_name = get_city_name
      country_code = get_country_code
      @weekly_arr = get_forecast_from_api(city_name, country_code)
    end
    @batch = Batch.new
    @num = get_number_of_days
    create_and_save_forecast(@num)

    Query.create(city: city_name, country_code: country_code, user: new_user, batch: @batch)

    display_result(@batch.forecasts)

  end

  def welcome
    puts "Hello! Welcome to WeatherCLI! Before we get to the weather:"
  end

  def get_user_name # gets user name
    puts "What is your name?"
    @username = gets.chomp
    new_user = User.find_or_create_by(name: @username)
    new_user
  end

  def get_city_name
    puts "Which city would you like to view weather for? Please enter city."
    city_name = gets.chomp
  end

  def get_country_code
    puts "Country code? Please enter country code as 2 characters **Use us for United States**"
    country_code = gets.chomp
  end

  def get_forecast_from_api(city_name, country_code)
    @instance_of_weatherapigetter.get_weather_forecast(city_name, country_code)
  end

  def get_number_of_days
    puts "How many days of weather? You can choose from 1 to 5 days."
    num = gets.chomp.to_i
  end

  def self.id
    @@id
  end

  def create_and_save_forecast(num)
    i = 0
     while i < num
      Forecast.create(temp: date_key_hash(i)["temp"], humidity: date_key_hash(i)["humidity"], date_text: date_key_hash(i)["date"], batch: @batch)
       i += 1
     end
  end

  def date_key_hash(index)#cleanup?
    new_date = {}
    new_date["date"]= @weekly_arr[index]["dt_txt"]
    new_key = @weekly_arr[index]["main"]
    date_key_hash = new_key.merge(new_date)
  end

  def display_result(arr_forecasts_obj)
    puts "Hi, #{@username}! Here’s the #{@num}-day forecast:"
    arr_forecasts_obj.each do |forecast|
      a = forecast.date_text
      print " Date: "
      p a
      puts " Temperature: #{forecast.temp} F \n Humidity: #{forecast.humidity}%"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    end
  end

end
