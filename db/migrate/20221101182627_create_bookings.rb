class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    drop_table(:bookings, if_exists: true)
    create_table :bookings do |t|
      t.integer :user_id, null: false
      t.date :booked_on_date, null: false
      t.string :origin, null: false
      t.string :destination, null: false
      t.date :departure_date, null: false
      t.date :return_date, null: false
      t.integer :adults, null: false
      t.string :class
      t.string :status, null: false
      t.decimal :total_price
      t.string :currency

      t.timestamps
    end
    add_index :bookings, :user_id
    add_index :bookings, :destination
    add_index :bookings, :status
  end
end
