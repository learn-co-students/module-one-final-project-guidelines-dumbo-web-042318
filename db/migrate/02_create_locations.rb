class CreateLocations < ActiveRecord::Migration[4.2]
    def change
        create_table :locations do |t|
            t.string :name
            t.boolean :legal_to_grow
            t.integer :legal_age
            t.string :legal_to_possess
            t.text :description
            t.timestamps
        end
    end
end