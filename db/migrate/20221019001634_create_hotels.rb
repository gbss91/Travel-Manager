class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.integer :booking_id, null: false
      t.string :hotel_name, null: false
      t.string :hotel_brand
      t.text :address
      t.string :city, null: false
      t.date :check_in_date, null: false
      t.time :check_in_time, null: false
      t.time :check_out_time, null: false
      t.string :board_type
      t.integer :no_nights, null: false
      t.float :rate, null: false
      t.float :total_price, null: false
      t.string :currency, null: false

      t.timestamps
    end
    add_index :hotels, :booking_id
    add_index :hotels, :hotel_name
    add_index :hotels, :hotel_brand
  end
end
