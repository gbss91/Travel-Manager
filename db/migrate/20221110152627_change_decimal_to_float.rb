class ChangeDecimalToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :total_price, :float, precision: 2
    change_column :flights, :total_price, :float, precision: 2
    change_column :hotels, :rate, :float, precision: 2
    change_column :hotels, :total_price, :float, precision: 2
  end
end
