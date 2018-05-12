require 'pry'

def welcome
    puts "Welcome to the 420 tripster"
    sleep 1
    puts "Would you like to begin your trip? (for sure / nah brah)"
end 

def exit
    puts "SEE YOU NEXT TIME, BROCHACHO!"
end

def line_spacers
    puts "-------------------------"
end 

def list_options(options)
    options.each do |option|
        puts option
        sleep 1
    end
end

def main_options
    options = [
        "- CREATE BLAZER : create a new blazer profile and book a trip my dude!",
        "- STATE INFO BRO : displays a list of questions",
        "- BOOK A TRIP : books that trip we talked about earlier brosef!",
        "- EXIT : exits this program"]
    list_options(options)
end 

def state_info_options
    options = [
        "-Which states can I chief my herbs?",
        "-Where can I grow my devil's lettuce?",
        "-How much tree can I have?",
        "-What are the legal limitations?",
        "-Hit that rewind button!"]
    list_options(options)
end 

def main_menu
    loop do
        main_options
        options_answer = gets.chomp
        options_choice(options_answer)
        sleep 1
        break if options_answer == "exit"
    end 
end

def new_prompt
    sleep 3
    puts "Select another option, bromigo or ask the same thing?? I don't care!"
    sleep 1
end

def blazer_prompt
    user_input = gets.chomp.downcase
    if user_input.include?("ye") || user_input.include?("for")
        new_blazer
    elsif user_input.chars.first == "n"
        puts "ok bromenheimerschmitz, we can do it later.."
    else
        puts "Say yea or negatory or something, bro. It'd be alot cooler if you did."
    end
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
    new_user = User.create(name: name, age: age, home_state: home_state)
    puts "Welcome #{name}, glad to have you along the chieftan trail!"
    new_user
end 

def list_all_locations
    puts "These states are all chill :"
    sleep 2
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
    sleep 2
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
    destination = Location.find_by(name: state)
    puts destination.description
    line_spacers
end

def booking_promt(user_instance)
    puts "Choose a destination, brosaurus"
    sleep 2
    list_all_locations
    user_destination = gets.chomp.capitalize
    puts "Enter a date and we'll get you sky high in two ways!"
    trip_date = gets.chomp
    book_a_trip(user_destination, trip_date, user_instance)
end

def book_a_trip(destination, date, user)
    new_trip = FourTwentyTrip.create(date_of_trip: date)
    new_trip.location = Location.find_by(name: destination)
    user.four_twenty_trips << new_trip
    puts "Have a totally bodacious trip to #{new_trip.location.name}, #{user.name}!"
end

def book_new_trip
    user_instance = user_check
    if user_instance != nil 
        user_instance
    else
        puts "You're not a member of this village. You down to make a new blazer?"
        user_instance = blazer_prompt
    end
    if user_instance != nil
        booking_promt(user_instance)
    end
end

def user_check
    if User.all != []
    puts "Is this you, chieftan #{User.all.last.name}?"
    ##this puts statement happens twice if user_input is 'yes', but after second 'yes', it works
    user_input = gets.chomp 
        if user_input.include?("ye") || user_input.include?("for")
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
    else
        return nil
    end
end

def options_choice(user_answer)
    case user_answer.downcase
        when "create blazer"
            puts "You ready to dive into that brocean, Broseidon?"
            blazer_prompt    
        when "state info bro"
            line_spacers
            puts "Try asking a question like these :"
            loop do 
                state_info_options
                user_state_option = gets.chomp
                line_spacers
                if user_state_option.include?("herb")
                    list_all_locations
                    new_prompt
                elsif user_state_option.include?("grow")
                    grow
                    new_prompt  
                elsif user_state_option.include?("how much") || user_state_option.include?("have")
                    sleep 1   
                    possession
                    new_prompt
                elsif user_state_option.include?("legal")
                    puts "Which state you want to know more about, bromeister?"
                    loop do   
                        user_input = gets.chomp
                        if user_input.include?("DC") 
                            legal_limitations("Washington, DC")
                            break
                        elsif Location.all.any? do |location_instance|
                                location_instance.name == user_input.capitalize
                            end 
                            legal_limitations(user_input.capitalize)
                            break
                        else
                            puts "Sorry, Brofessor X. You put the wrong input."
                            list_all_locations
                        end
                    end
                    new_prompt
                end    
                break if user_state_option.include?("rewind")
            end
        when "book a trip"
            book_new_trip
        when "exit"
            exit
    end
end 

def four_twenty_tripster_cli_interface
   welcome 
   begin_answer = gets.chomp
    if begin_answer == "nah brah"
        puts "Well stay chill bromenheim, til the next episode!"
    elsif begin_answer == "for sure"
        line_spacers
        puts "Follow these commands to start your journey :"
        sleep 1
        main_menu
    end
end 

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