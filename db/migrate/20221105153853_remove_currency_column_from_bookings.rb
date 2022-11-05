class RemoveCurrencyColumnFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :currency
  end
end
