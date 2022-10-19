class AddIndexFlights < ActiveRecord::Migration[7.0]
  def change
    add_index :flights, :booking_id
  end
end
