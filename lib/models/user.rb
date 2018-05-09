class User < ActiveRecord::Base

    has_many :fourtwentytrips
    has_many :locations, through: :fourtwentytrips

    # def self.create_user(name, age, home_state)
    #     User.create(name, age, home_state)
    #     puts "Welcome #{name}, glad to have you along the chieftan trail!"
    # end  

    # ##When they respond with book a trip, enter their user name followed by the state they want to travel to.
    # #gets.chomp their name and state as a single string, then split into array
    # ##and take just answer_array[0] for name and answer_array[1] to plug in 
    # ##as arguments
    # ##maybe add a unique trip number?
    # def self.book_a_trip(name, state)
    #     user = User.find_by(:name => name)
    #     new_trip = ForTwentyTrip.new
    #     new_trip.location = Location.find_by(:name => "#{state}")
    #     user.fourtwentytrips << new_trip
    #     puts "Have an awesome trip to #{new_trip.location.name}, #{name}"
    # end 

    # ##When they respond with "get my info", ask for user name
    # ##gets.chomp the name
    # def self.get_my_info(name)
    #     user = User.find_by(:name => name)
    #     user_locations = user.fourtwentytrips.map do |location|
    #                 location.name
    #     end 
    #     puts "Yo #{user.name}, your destinations are: "
    #     user_locations.each do |location_name|
    #         puts "#{location_name}"
    #     end 
    # end 

end 