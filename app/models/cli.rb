require "pry"
class CommandLineInterface

  def main_menu
    puts "Hello admin!".white.on_red
    puts "Type 1 for search".green #Reading
    puts "Type 2 to work with database".red #Create, Delete, Update
    puts "Type 3 to view all movies".blue
    puts "Type 4 to view all venues"
    puts "Type exit to terminate the program!".green
  end
  def greeting(response)
      # puts "Hello admin!".white.on_red
      # puts "Type 1 for search".green #Reading
      # puts "Type 2 to work with database".red #Create, Delete, Update
      # puts "Type 3 to view all movies".blue
      # puts "Type 4 to view all venues"

      case response
      when "1"
        self.search_navigation
      when "2"
        self.working_with_database
      when "3"
        self.view_movies
      when "4"
        self.view_venues
      else
        self.greeting
      end
    end

    def working_with_database
      puts "Type 1 to add a new movie".red
      #Upadate boolean showing
      #Update rating
      puts "Type 2 to add a new location".blue #Create
      puts "Type 3 to remove a location" #Delete
      puts "Type 4 to create showtime".red
      puts "Type 5 to update movie rating".green
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
      when "5"
        self.update_movie_rating
      else
        self.greeting
      end
    end

    def create_movie
      puts "Please enter a title".green
      title_response = gets.chomp
      puts "Please enter a genre".green
      genre_response = gets.chomp
      puts "Please enter a rating".green
      rating_response = gets.chomp
      result = Movie.create(title: title_response, genre:genre_response, rating:rating_response)
      # puts "Movie ID = #{result.id}"
      puts "#{result.title} has been added to your collection".blue
      puts "-----------------------------------------------------"
      tp Movie.all, "title", "genre", "rating"
    end


    def create_location
      puts "Please enter a theater name".red
      t_response = gets.chomp
      puts "Please enter an address".red
      a_response = gets.chomp
      puts "Please enter a neighborhood".red
      n_response = gets.chomp
      result = Location.create(theater_name: t_response, address: a_response, neighborhood: n_response)
      # puts "Location ID = #{result.id}"
      puts "#{result.theater_name} is now in service and playing movies near you!".blue
      puts "-----------------------------------------------------"
      tp Location.all, "theater_name", "address", "neighborhood"
    end

    def delete_location
      puts "Would you like to delete by venue or address".green
      puts "Type 1 for venue".green
      puts "Type 2 for address".green

      response = gets.chomp

      case response
      when "1"
        puts "Please enter the theater name you would like to delete".blue
        t_response = gets.chomp
        theater = Location.find_by(theater_name: t_response)
        theater.destroy
        puts "#{theater.theater_name} is no longer in service".blue
      when "2"
        puts "Please enter the address of the theater you would like to delete".blue
        a_response = gets.chomp
        address = Location.find_by(address: a_response)
        address.destroy
        puts "#{theater.theater_name} is no longer in service".blue
      else
        self.greeting
      end
    end

    def create_showtime
      puts "Please enter time for which the movie you would like to see".red
      t_response = gets.chomp
      puts "Please enter the price".red
      p_response = gets.chomp
      puts "Is the movie 3-D? Type true or false".red
      three_d_response = gets.chomp
      puts "Please enter the movie title".red
      m_response = gets.chomp
      m_find = Movie.find_by(title: m_response)
      m_id = m_find.id
      puts "Please enter the venue name".red
      v_response = gets.chomp
      v_find = Location.find_by(theater_name: v_response)
      v_id = v_find.id
      result = ShowTime.new(time: t_response, price: p_response, three_d: three_d_response, location_id: v_id, movie_id: m_id)
      puts "#{m_find.title} is now playing at #{v_find.theater_name} at #{result.time}"
    end



    def update_movie_rating
      puts "Please enter the movie title".blue
      m_response = gets.chomp
      m_find = Movie.find_by(title: m_response)
      old_r = m_find.rating
      puts "Please enter the number you would like to give as rating for the movie".blue
      r_response = gets.chomp
      m_update = m_find.update(rating: r_response)
      # puts "You have given #{m_response} a rating of #{r_response}"
      puts "#{m_find.title}'s rating has been updated from #{old_r} to #{r_response}"
      puts "-----------------------------------------------------"
      tp Movie.all, "title", "rating"
    end

    def search_navigation
      puts "How would you like to search by?".green
      puts "Type 1 for movie".green
      puts "Type 2 for location".green
      puts "Type 3 for showtimes".green

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
    puts "Please enter movie title".blue
    movie_response = gets.chomp
    result = Movie.find_by(title: movie_response)
    # puts "Title: #{result.title}"
    # puts "Genre : #{result.genre} "
    # puts "Rating: #{result.rating}"
    #tp result.title
    # if there is no movie, do no movie found
    if result == nil
      puts "Sorry this movie is not in our database".red
    else
     puts "*******************************************************"
     puts "Title: #{result.title}".blue
     puts "Genre : #{result.genre}".blue
     puts "Rating: #{result.rating}".blue
   end
  end

  def view_movies
    tp Movie.all
  end

  def view_venues
    tp Location.all
  end

  def find_by_location
    puts "Type 1 for neighborhood".red
    puts "Type 2 for movie theater".red
    response = gets.chomp
    if response == "1"
      puts "Please enter a neighborhood".red
      neighborhood_response = gets.chomp
      result = Location.find_by(neighborhood: neighborhood_response)
      puts "Neighborhood: #{result.neighborhood}".red
      puts "Address: #{result.address}".red
    elsif response == "2"
      puts "Please enter a movie theater".red
      theater_response = gets.chomp
      result = Location.find_by(theater_name: theater_response)
      puts "Theater: #{result.theater_name}".red
      puts "Address: #{result.address}".red
    else
      self.find_by_location
    end
  end

  def find_by_showtime
    puts "Please enter time with the hour + AM/PM".blue
    time_response = gets.chomp
    result = ShowTime.find_by(time: time_response)
    movie = Movie.find_by(id: result.movie_id)
    movie_title = movie.title
    location = Location.find_by(id: result.location_id)
    location_venue = location.theater_name
    # puts "#{movie_title} that are playing at #{location_venue} at #{time_response}"
    tp ShowTime.all, "movie.title", "time", "location.theater_name"
  end

  def run_cli
      loop do
        main_menu
        response = gets.chomp
        if response != "exit"
          greeting(response)
        else
          break
        end
      end
  end

end
