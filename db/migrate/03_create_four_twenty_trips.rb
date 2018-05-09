class CreateFourTwentyTrips < ActiveRecord::Migration
    def change
        create_table :four_twenty_trips do |t|
            t.integer :user_id
            t.integer :location_id
        end
    end
end