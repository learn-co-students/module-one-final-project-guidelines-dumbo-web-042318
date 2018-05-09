class CreateQueries < ActiveRecord::Migration[5.0]
  def change
    create_table :queries do |t|
      t.string :city
      t.string :country_code
      t.integer :user_id
      t.integer :forecast_id
    end
  end
end
