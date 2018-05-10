class CommandLineInterface
  def greeting
    puts "Hello! How would you like to search by?"
    puts "Type 1 for movie"
    puts "Type 2 for location"
    puts "Type 3 for showtimes"

    response = gets.chomp

    case response
    when "1"
      self.find_movie_by_title
    when "2"
      self.find_by_location
    when "3"
      self.find_by_showtime
    else
      self.greeting
    end


  end

  def find_movie_by_title
    puts "Please enter movie title"
    movie_response = gets.chomp
    result = Movie.find_by(title: movie_response)
    puts "Title: #{result.title}"
    puts "Genre : #{result.genre} "
    puts "Rating: #{result.rating}"
  end

  def find_by_location
    puts "Type 1 for neighborhood"
    puts "Type 2 for movie theater"
    response = gets.chomp
    if response == "1"
      puts "Please enter a neighborhood"
      neighborhood_response = gets.chomp
      result = Location.find_by(neighborhood: neighborhood_response)
      puts "Neighborhood: #{result.neighborhood}"
      puts "Address: #{result.address}"
    elsif response == "2"
      puts "Please enter a movie theater"
      theater_response = gets.chomp
      result = Location.find_by(theater_name: theater_response)
      puts "Theater: #{result.theater_name}"
      puts "Address: #{result.address}"
    else
      self.find_by_location
    end
  end

  def find_by_showtime
    puts "Please enter date and time in this format YYYYMMDDHHMMSS"
    time_response = gets.chomp
    Showtime.find_by(time: time_response)
  end

end
