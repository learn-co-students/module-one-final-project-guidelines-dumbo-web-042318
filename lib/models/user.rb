class User < ActiveRecord::Base

    has_many :fortwentytrips
    has_many :locations, through: :fortwentytrips

    def self.create_user(name, age, home_state)
        User.create(name, age, home_state)
    end  

    

    def legal_to_sell_in(state)
        searched_state = Location.find_by(:name => "#{state}")
       searched_state.legal_to_sell
    end 

    def legal_to_grow_in(state)
        searched_state = Location.find_by(:name => "#{state}")
       searched_state.legal_to_grow
    end 

    def legal_age(state)
       searched_state = Location.find_by(:name => "#{state}")
       searched_state.legal_age
    end 

    def is_it_legal_to_possess(state)
        searched_state = Location.find_by(:name => "#{state}")
        searched_state.legal_to_posses
    end 

    def book_a_trip(state)
        new_trip = ForTwentyTrip.new
        new_trip.location = Location.find_by(:name => "#{state}")
        self.fortwentytrips << new_trip
    end 

    

end 