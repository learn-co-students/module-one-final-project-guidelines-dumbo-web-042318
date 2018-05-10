require 'pry'

def welcome
    puts "Welcome to the 420 tripster"
    sleep 1
    puts "Would you like to begin your trip? (for sure / nah brah)"
end 

def line_spacers
    puts "------"
end 

def list_options(options)
    line_spacers
    options.each do |option|
        puts option
        sleep 1
    end
end

def main_options
    options = [
        "- create blazer : create a new blazer profile and book a trip my dude!",
        "- state info bro : displays a list questions",
        "- book a trip : books that trip we talked about earlier brosef!",
        "- exit : exits this program"]
    list_options(options)
end 

def users 
    User.all.each do |user|
        binding.pry
        puts user 
    end 
end

def state_info_options
    options = [
        "-I want to know which states I can chief my herbs",
        "-I want to know what states you can grow in",
        "-How much can I possess in a state?",
        "-What are the legal limitations",
        "-Hit that rewind button!"]
    list_options(options)
end 

def new_prompt
    sleep 2
    puts "Select another option, bromigo or ask the same thing?? I don't care!"
    sleep 1
end

def new_blazer
    puts "Enter your name"
    user_name = gets.chomp
    puts "Enter your age"
    user_age = gets.chomp
    puts "Enter your state"
    user_state = gets.chomp
    create_blazer(user_name, user_age, user_state)
end

def create_blazer(name, age, home_state)
    User.create(name: name, age: age, home_state: home_state)
    puts "Welcome #{name}, glad to have you along the chieftan trail!"
end 

def list_all_locations
    puts "These states are all chill :"
    Location.all.each do |location|
        puts "-#{location.name}"
        sleep 1
    end 
    line_spacers
end

def grow
    puts "Get your gardens ready, dudes and dudettes!"
    sleep 1
    puts "You can start your herb havens here :"
    Location.all.select do |location|
        location.legal_to_grow == true
    end.each do |instance|
       puts instance.name 
       sleep 1
    end
    line_spacers
end 

def possession
    puts "How much tree are you bringing? Make sure its no more than:"
    Location.all.map do |location|
        puts "#{location.legal_to_possess} oz in #{location.name}"
        sleep 1
    end
    line_spacers
end

def legal_limitations(state)
    line_spacers
    destination = Location.find_by(name: state.capitalize)
    puts destination.description
    line_spacers
end

def book_a_trip(destination, date, user)
    new_trip = FourTwentyTrip.new(:date_of_trip => date)
    new_trip.location = Location.find_by(:name => destination)
    user.four_twenty_trips << new_trip
    puts "Have a totally bodacious trip to #{new_trip.location.name}, #{user.name}!"
end

def user_check
    puts "Is this you, Chieftan #{User.all.last.name}?"
    ##this puts statement happens twice if user_input is 'yes', but after second 'yes', it works
    user_input = gets.chomp 
    if user_input.include?("ye")
        puts "Great brometheus, let's book that trip!"
        return User.all.last
    elsif user_input.include?("n")
        puts "I'm totally spacing, bro. Whats your name again?"
        user_name = gets.chomp.capitalize 
        user = User.find_by(name: user_name)
        if user
            puts "My bad, brobro. Let's book your trip, chieftan #{user.name}!"
            return user
        else
            return nil
        end
    end
end

def options_choice(user_answer)
    case user_answer
        when "create blazer"
            new_blazer
            ##THIS WAS TRYING TO ADD A BOOK_A_TRIP PATH DIRECTLY AFTER NEW_BLAZER WAS MADE...NOT WORKING THO.
            # new_blazer_instance = new_blazer
            # ##new_blazer_instance == nil...even tho new_blazer runs fine...por que?
            # binding.pry
            # line_spacers
            # puts "Wanna just book a trip right now?! "
            # booking_response = gets.chomp
            # if booking_response.include?("ye") || booking_response.include?("for sure")
            #     ##maybe make a method for this book--'booking prompt?'
            #     puts "Choose a destination, brosaurus"
            #     sleep 2
            #     list_all_locations
            #     user_destination = gets.chomp
            #     puts "when you wanna go?"
            #     trip_date = gets.chomp
            #     binding.pry
            #     ##issue here, taking this path, new_blazer_instance returns nil, even tho new_blazer method above seemed to work
            #     book_a_trip(user_destination, trip_date, new_blazer_instance)
            # else
            #     puts "That's chill, welcome to the squad!"
            #     line_spacers
            # end
        when "state info bro"
            line_spacers
            puts "choose an option :"
            loop do 
                state_info_options
                user_state_option = gets.chomp
                if user_state_option.include?("herb")
                    list_all_locations
                    new_prompt
                elsif user_state_option.include?("grow")
                    grow
                    new_prompt  
                elsif user_state_option.include?("possess")    
                    possession
                    new_prompt
                elsif user_state_option.include?("legal")
                    puts "Which state you want to know more about, bromeister?"
                    user_input = gets.chomp
                    legal_limitations(user_input)
                    new_prompt
                end    
                break if user_state_option.include?("rewind")
            end
        when "book a trip"
            user_instance = []
            if user_check == nil 
                puts "You're not a member of this village. Let's create a new blazer!"
                new_blazer
            else
                user_instance = user_check
            end
            ##this again...turn this into #booking_prompt ?
            puts "Choose a destination, brosaurus"
            sleep 2
            list_all_locations
            user_destination = gets.chomp
            puts "when you wanna go?"
            trip_date = gets.chomp
            book_a_trip(user_destination, trip_date, user_instance)
        when "exit"
            puts "SEE YOU NEXT TIME, BROCHACHO!"
    end
end 


def four_twenty_tripster_cli_interface
   welcome 
   begin_answer = gets.chomp
    if begin_answer == "nah brah"
        puts "Well stay chill bromenheim, til the next episode!"
    elsif begin_answer == "for sure"
        line_spacers
        puts "Follow these commands to start your journey:"
        sleep 1
        loop do
            main_options
            options_answer = gets.chomp
            options_choice(options_answer)
            sleep 1
            break if options_answer == "exit"
        end 
    end 

end 

