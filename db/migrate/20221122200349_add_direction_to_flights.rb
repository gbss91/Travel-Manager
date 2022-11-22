class AddDirectionToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :direction, :string, null: false
  end
end
