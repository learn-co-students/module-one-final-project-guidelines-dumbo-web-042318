
class WeatherCLI

  def initialize
    @instance_of_weatherapigetter = WeatherAPIGetter.new
  end

  def welcome
    welcome_message
    @new_user = get_user_name
  end

  def run
    safely_run
    @batch = Batch.new
    @num = get_number_of_days
    create_and_save_forecast(@num)
    Query.create(city: @city_name, country_code: @country_code, user: @new_user, batch: @batch)
    display_result(@batch.forecasts)
    fun_info
  end

  def safely_run
    city_name = get_city_name
    country_code = get_country_code
    begin
    @weekly_arr = get_forecast_from_api(city_name, country_code)
    rescue
      puts "Oops. Try again."
      safely_run
    end
  end

  def safely_run
    city_name = get_city_name
    country_code = get_country_code
    begin
    @weekly_arr = get_forecast_from_api(city_name, country_code)
    rescue
      puts "Oops. Try again."
      safely_run
    end
  end

  def welcome_message
    puts "Hello! Welcome to WeatherCLI! Before we get to the weather:"
  end

  def get_num_days
    puts "how many days do you want?"

    num = gets.chomp.to_i
    if num>5
       num=5
     elsif num<0
       num=1
     else
       num
     end
  end

  def get_user_name # gets user name
    puts "What is your name?"
    @username = gets.chomp
    new_user = User.find_or_create_by(name: @username)
    new_user
  end

  def get_city_name
    puts "Which city would you like to view weather for? Please enter city."
    @city_name = gets.chomp
  end

  def get_country_code
    puts "Country code? Please enter country code as 2 characters **Use us for United States**"
    @country_code = gets.chomp
  end

  def get_forecast_from_api(city_name, country_code)
    @instance_of_weatherapigetter.get_weather_forecast(city_name, country_code)
  end

  def get_number_of_days
    puts "How many days of weather? You can choose from 1 to 5 days."
    num = gets.chomp.to_i
    if num ==42
      puts"insert cool easter egg here developers"
    elsif num <=0
      puts"MINIMUM OF ONE DAY!!!!!!!!!!!"
      num = 1
    elsif num >5
      puts"ONLY 5 DAYS!!!!!!!!!!"
      num = 5
    else
      num
    end
  end

  def self.id
    @@id
  end

  def create_and_save_forecast(num)
    i = 0
     while i < num
       hash_key = date_key_hash(i)
      Forecast.create(temp: hash_key["temp"], humidity: hash_key["humidity"], date_text: hash_key["date"], weather: hash_key["description"], batch: @batch)
       i += 1
     end
  end

  def date_key_hash(index)#cleanup?
    new_date = {}
    new_date["date"]= @weekly_arr[index]["dt_txt"]
    new_date["description"]= @weekly_arr[index]["weather"][0]["description"]
    new_key = @weekly_arr[index]["main"]
    date_key_hash = new_key.merge(new_date)
  end

  def display_result(arr_forecasts_obj)
    puts "Hi, #{@username}! Here’s the #{@num}-day forecast:"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    arr_forecasts_obj.each do |forecast|
      a = forecast.date_text
      print " Date: "
      p a
      puts " Description: #{forecast.weather} \n Temperature: #{forecast.temp} F \n Humidity: #{forecast.humidity}%"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    end
  end

  def exit_message
    puts "Thank you for using WeatherCLI! Have a nice day!"
  end

  def fun_info
    puts "Welcome to fun info!"
    puts "Enter search to make a new search."
    puts "Enter history to see search history."
    puts "Enter high to see high of each day of your search."
    puts "Enter low to see low of each day of your search."
    puts "Enter x to exit program."
    input = gets.chomp.downcase
    case input
    when "search"
      run
    when "history"
      history
      fun_info
    when "low"
      min_temp
      fun_info
    when "high"
      high_temp
      fun_info
    when 'x'
      exit_message
    else
      fun_info
    end
  end

  def history
    puts "Here's all the forecasts you've searched:"
    display_result(@new_user.forecasts.last)
  end

  def order_batch
    @new_user.forecasts.last.sort_by{|forecast| forecast.temp}
  end

  def min_temp
    min = order_batch.first
    a = min.date_text
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "The coldest day is:"
    print " Date: "
    p a
    puts " Temperature: #{min.temp} F"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end

  def high_temp
    max = order_batch.last
    a = max.date_text
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "The hottest day is:"
    print " Date: "
    p a
    puts " Temperature: #{max.temp} F"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end


end
