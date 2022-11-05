class RemoveCurrencyColumnFromFlights < ActiveRecord::Migration[7.0]
  def change
    remove_column :flights, :currency
  end
end
