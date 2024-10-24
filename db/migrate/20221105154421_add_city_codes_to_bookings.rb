class AddCityCodesToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, "origin_city_code", :string, null: false, after: :origin
    add_column :bookings, "destination_city_code", :string, null: false, after: :destination
  end
end
