class RemoveForeignKeyHotels < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :hotels, :bookings, column: :id, primary_key: "id"
  end
end
