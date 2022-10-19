class ChangeBookingColumnsToNotNul < ActiveRecord::Migration[7.0]
  def change
    change_column_null(  :bookings, :user_id, false)
    change_column_null(  :bookings, :booked_on, false)
    change_column_null(  :bookings, :trip_date, false)
    change_column_null(  :bookings, :destination, false)
    change_column_null(  :bookings, :status, false)
    change_column_null(  :bookings, :total_price, false)
    change_column_null(  :bookings, :currency, false)
  end
end
