class CreateUsers < ActiveRecord::Migration[4.2]
    def change
        create_table :users do |t|
            t.string :name
            t.integer :age
            t.string :home_state
            t.timestamps
        end
    end
end