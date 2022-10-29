class RemoveDuplicateForeignKeyHotels < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :hotels, :bookings
  end
end
