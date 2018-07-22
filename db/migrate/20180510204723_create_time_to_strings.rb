class CreateTimeToStrings < ActiveRecord::Migration[5.2]
    def change
      change_column :show_times, :time, :string
    end
  end
