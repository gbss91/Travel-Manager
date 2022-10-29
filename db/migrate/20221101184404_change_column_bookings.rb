class ChangeColumnBookings < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :class, :booking_class
  end
end
