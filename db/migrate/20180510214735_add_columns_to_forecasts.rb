class AddColumnsToForecasts < ActiveRecord::Migration[5.0]
  def change
    add_column :forecasts, :weather, :string
  end
end
