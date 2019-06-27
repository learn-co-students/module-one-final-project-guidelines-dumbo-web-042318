class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |m|
      m.string :title
      m.string :genre
      m.integer :rating
    end
  end
end
