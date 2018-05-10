class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |l|
      l.string :theater_name
      l.string :address
    end
  end
end
