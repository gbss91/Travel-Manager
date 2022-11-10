class AddCarrierCodeToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :carrier_code, :string, null: false, after: :id
  end
end
