class AddBookingIdToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column(:flights, :booking_id, :integer, null: false)
  end
end
