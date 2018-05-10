require 'pry'

def welcome
    puts "Welcome to the 420 tripster"
    sleep 1
    puts "Would you like to begin your trip? (for sure / nah brah)"
end 

def list_options(options)
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
    puts "These states are all chill"
    Location.all.each do |location|
        puts location.name
        sleep 1
    end 
end

def grow
    puts "Get your gardens ready, dudes and dudettes!"
    sleep 1
    puts "You can start your herb havens here:"
    Location.all.select do |location|
        location.legal_to_grow == true
    end.each do |instance|
       puts instance.name 
       sleep 1
    end
end 

def possession
    puts "How much tree are you bringing? Make sure its no more than:"
    Location.all.map do |location|
        puts "#{location.legal_to_possess} oz in #{location.name}"
        sleep 1
    end
end

def legal_limitations(state)
    destination = Location.find_by(name: state.capitalize)
    puts destination.description
end

def user_check
    puts "Is this you, Chieftan #{User.all.last.name}?"
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
        when "state info bro"
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
            puts "choose a destination, brosaurus"
            sleep 2
            list_all_locations
            user_destination = gets.chomp
            puts "when you wanna go?"
            trip_date = gets.chomp
            book_a_trip(user_input, trip_date)
        when "exit"
            puts "see you next time, brochacho!"
    end
end 

def book_a_trip(destination)
    new_trip = ForTwentyTrip.new()
    new_trip.location = Location.find_by(:name => "#{state}")
    user.fourtwentytrips << new_trip
    puts "Have an awesome trip to #{new_trip.location.name}, #{name}"
end

def four_twenty_tripster_cli_interface
   welcome 
   begin_answer = gets.chomp
    if begin_answer == "nah brah"
        puts "well stay chill bromenheim, til the next episode"
    elsif begin_answer == "for sure"
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

