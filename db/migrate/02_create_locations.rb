class CreateLocations < ActiveRecord::Migration
    def change
        create_table :locations do |t|
            t.string :name
            t.boolean :legal_to_sell
            t.boolean :legal_to_grow
            t.integer :legal_age
            t.string :legal_to_posses
        end
    end
end