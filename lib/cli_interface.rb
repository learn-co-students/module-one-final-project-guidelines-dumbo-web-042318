require 'pry'

def welcome
    puts "Welcome to the 420 tripster"
    puts "Would you like to begin your trip? (for sure / nah brah)"
end 

def options
    puts "Follow these commands to start your journey:"
    puts "- create blazer : create a new blazer profile and book a trip my dude!"
    puts "- state info bro : displays a list questions"
    puts "- exit : exits this program"
end 

def state_info_options
    puts "-I want to know in which states the herb is legal"
    puts "-I want to know what states you can grow in"
    puts "-How much can I possess in a state?"
    puts "-What are the legal limitations"
end 

def create_blazer(name, age, home_state)
    User.create(name: name, age: age, home_state: home_state)
    puts "Welcome #{name}, glad to have you along the chieftan trail!"
end 

def list_all_locations
    puts "These states are all chill"
    Location.all.each do |location|
        puts location
    end 
end

def options_choice(user_answer)
    case user_answer
        when "create blazer"
            puts "Enter your name"
            user_name = gets.chomp
            puts "Enter your age"
            user_age = gets.chomp
            puts "Enter your state"
            user_state = gets.chomp
            create_blazer(user_name, user_age, user_state)

        when "state info bro"
            puts "choose an option :"
            state_info_options
            user_state_option = gets.chomp
            if user_state_option.include?("herb")
                list_all_locations
            end

        when "exit"
            puts "see you next time, brochacho!"
    end
end 



def four_twenty_tripster_cli_interface
   welcome 
   begin_answer = gets.chomp
    if begin_answer == "nah brah"
        puts "well stay chill my bro, til the next episode"
    elsif begin_answer == "for sure"
        puts "tight, let's get this moving"
        loop do
            options
            options_answer = gets.chomp
            options_choice(options_answer)
            break if options_answer == "exit"

        end 
    end 

end 

