json.extract! booking, :id, :booking_id, :user_id, :booked_on, :trip_date, :destination, :status, :total_price, :currency, :created_at, :updated_at
json.url booking_url(booking, format: :json)
