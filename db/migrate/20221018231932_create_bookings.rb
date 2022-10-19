class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.date :booked_on
      t.date :trip_date
      t.string :destination
      t.string :status
      t.float :total_price
      t.string :currency

      t.timestamps
    end
  end
end
