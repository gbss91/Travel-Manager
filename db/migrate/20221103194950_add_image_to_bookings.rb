class AddImageToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :img_url, :string
  end
end
