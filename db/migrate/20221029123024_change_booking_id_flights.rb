class ChangeBookingIdFlights < ActiveRecord::Migration[7.0]
  def change
    change_column :flights, :booking_id, :bigint
  end
end
