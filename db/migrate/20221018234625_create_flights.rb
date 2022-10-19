class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.string :flight_no, null: false
      t.string :carrier, null: false
      t.string :origin_city, null: false
      t.string :destination_city, null: false
      t.datetime :departure_time, null: false
      t.datetime :arrival_time, null: false
      t.datetime :duration, null: false
      t.integer :adults, null: false
      t.float :total_price, null: false
      t.string :currency, null: false

      t.timestamps
    end
    add_index :flights, :flight_no
    add_index :flights, :carrier
  end
end
