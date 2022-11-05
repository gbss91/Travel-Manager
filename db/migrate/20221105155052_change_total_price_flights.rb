class ChangeTotalPriceFlights < ActiveRecord::Migration[7.0]
  def change
    change_column :flights, :total_price, :decimal, precision: 10, scale: 2
  end
end
