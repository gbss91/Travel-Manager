class AddColumnToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :booking_type, :string, null:false
  end
end
