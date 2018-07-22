class AddingNeighborhoodToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :neighborhood, :string
  end
end
