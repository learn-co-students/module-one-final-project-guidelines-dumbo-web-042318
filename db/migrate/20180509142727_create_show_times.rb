class CreateShowTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :show_times do |u|
      u.datetime :time
      u.integer :price
      u.boolean :three_d
      u.integer :location_id
      u.integer :movie_id
    end
  end
end
