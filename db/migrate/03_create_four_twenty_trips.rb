class CreateFourTwentyTrips < ActiveRecord::Migration
    def change
        create_table :four_twenty_trips do |t|
            t.integer :user_id
            t.integer :location_id
            t.datetime :date_of_trip
            t.timestamps
        end
    end
end