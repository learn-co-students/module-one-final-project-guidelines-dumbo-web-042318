class Location < ActiveRecord::Base

    has_many :four_twenty_trips
    has_many :users, through: :four_twenty_trips
    
    # ##corresponding question - "What states have legal 420?"
    # def self.list_all_locations
    #     locations = Location.all
    #     puts "These states are all chill"
    #     locations.each do |location_instance|
    #         puts "  -#{location_instance.name}"
    #     end 
    # end

    # ##corresponding question - "What states are legal to sell in?"
    # ##argument fo
    # def self.legal_to_sell_in
    #     puts "These states are make it legal to sell"
    #     locations = Location.find_by(:legal_to_sell => true)
    #     locations.each do |location_instance|
    #         puts "  -#{location_instance.name}"
    #     end 
    # end 

    # ##corresponding question - "What states are legal to grow in?"
    # def self.legal_to_grow_in
    #     puts "These states are make it legal to grow your own goods"
    #     locations = Location.find_by(:legal_to_grow => true)
    #     locations.each do |location_instance|
    #         puts "  -#{location_instance.name}"
    #     end 
    # end 

    # ##corresponding question - "What's the legal age in (state)?"
    # ##will have to cut the question mark off the gets.chomp, 
    #     #then split into array, select last item and use as arg for method
    # def self.legal_age(state)
    #    searched_state = Location.find_by(:name => "#{state}")
    #    puts "You have to be #{searched_state.legal_age} in the state of #{searched_state.name}"
    # end 

    # ##corresponding question - "Is it legal to possess in (state)?"
    # ##similar process as above
    # def self.is_it_legal_to_possess(state)
    #     searched_state = Location.find_by(:name => "#{state}")
    #     puts "#{searched_state.name} is def chill to possess"
    # end 

    # def self.most_popular_state

    # end 

    

end 