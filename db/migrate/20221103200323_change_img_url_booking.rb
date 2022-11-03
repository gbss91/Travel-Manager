class ChangeImgUrlBooking < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :img_url, :text
  end
end
