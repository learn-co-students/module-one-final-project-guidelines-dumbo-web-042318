class CommandLineInterface
  def greeting
    puts "Hello! How would you like to search by?"
    puts "Type 1 for movie"
    puts "Type 2 for movie theater"
    puts "Type 3 for showtimes"

    response = gets.chomp

    # switch logic to case 
    if response == 1
      response1
    elsif response == 2
      response2
    elsif response == 3
      response3
    else
      #greeting
      "Going to the else"
    end


  end

  def find_movie_by_title
    puts "Please enter movie title"
    movie_response = gets.chomp
    result = Movie.find_by(title: movie_response)
    puts result
    puts "Title: #{result.title}"
    puts "Genre : #{result.genre} "
    puts "Rating: #{result.rating}"
  end

  def find_by_location
    puts "Please enter a theater name or a neighborhooh"
    theater_response = gets.chomp
    Location.find_by(theater_name: theater_response)
  end

  def find_by_showtime
    puts "Please enter date and time in this format YYYYMMDDHHMMSS"
    time_response = gets.chomp
    Showtime.find_by(time: time_response)
  end

end
