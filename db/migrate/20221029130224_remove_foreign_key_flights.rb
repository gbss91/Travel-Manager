class RemoveForeignKeyFlights < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :flights, :bookings, column: :id, primary_key: "id"
  end
end
