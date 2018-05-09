class Location < ActiveRecord::Base

    has_many :fortwentytrips
    has_many :users, through: :fortwentytrips
    
    def self.list_all_locations
        Location.all
    end

    

end 