require "pry"
class CommandLineInterface
  def greeting
      puts "Hello admin!"
      puts "Type 1 for search" #Reading
      puts "Type 2 to work with database" #Create, Delete, Update

      response  = gets.chomp

      case response
      when "1"
        self.search_navigation
      when "2"
        self.working_with_database
      else
        self.greeting
      end
    end

    def working_with_database
      puts "Type 1 to add a new movie"
      #Upadate boolean showing
      #Update rating
      puts "Type 2 to add a new location" #Create
      puts "Type 3 to remove a location" #Delete
      puts "Type 4 to create showtime"
      response  = gets.chomp

      case response
      when "1"
        self.create_movie
      when "2"
        self.create_location
      when "3"
        self.delete_location
      when "4"
        self.create_showtime
      else
        self.greeting
      end
    end

    def create_movie
      puts "Please enter a title"
      title_response = gets.chomp
      puts "Please enter a genre"
      genre_response = gets.chomp
      puts "Please enter a rating"
      rating_response = gets.chomp
      puts result = Movie.create(title: title_response, genre:genre_response, rating:rating_response)
      puts "Movie ID = #{result.id}"
    end


    def create_location
      puts "Please enter a theater name"
      t_response = gets.chomp
      puts "Please enter an address"
      a_response = gets.chomp
      puts "Please enter a neighborhood"
      n_response = gets.chomp
      result = Location.create(theater_name: t_response, address: a_response, neighborhood: n_response)
      puts "Location ID = #{result.id}"
    end

    def delete_location
      puts "Would you like to delete by venue or address"
      puts "Type 1 for venue"
      puts "Type 2 for address"

      response = gets.chomp

      case response
      when "1"
        puts "Please enter the theater name you would like to delete"
        t_response = gets.chomp
        theater = Location.find_by(theater_name: t_response)
        theater.destroy
        puts "This theater is no longer in service"
      when "2"
        puts "Please enter the address of the theater you would like to delete"
        a_response = gets.chomp
        address = Location.find_by(address: a_response)
        address.destroy
        puts "This theater is no longer in service"
      else
        self.greeting
      end
    end

    def create_showtime
      puts "Please enter time for which the movie you would like to see"
      t_response = gets.chomp
      puts "Please enter the price"
      p_response = gets.chomp
      puts "Is the movie 3-D? Type true or false"
      three_d_response = gets.chomp
      puts "Please enter the movie title"
      m_response = gets.chomp
      m_find = Movie.find_by(title: m_response)
      m_id = m_find.id
      puts "Please enter the venue name"
      v_response = gets.chomp
      v_find = Location.find_by(theater_name: v_response)
      v_id = v_find.id
      result = ShowTime.new(time: t_response, price: p_response, three_d: three_d_response, location_id: v_id, movie_id: m_id)
      puts "Movie "
    end

    def search_navigation
      puts "How would you like to search by?"
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
        self.search_navigation
      end
    end

  #Search Methods
  def find_movie_by_title
    puts "Please enter movie title"
    movie_response = gets.chomp
    result = Movie.find_by(title: movie_response)
    puts "Title: #{result.title}"
    puts "Genre : #{result.genre} "
    puts "Rating: #{result.rating}"
    # if there is no movie, do no movie found
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
