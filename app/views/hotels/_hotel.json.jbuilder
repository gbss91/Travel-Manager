json.extract! hotel, :id, :booking_id, :hotel_name, :hotel_brand, :address, :city, :check_in_date, :check_in_time, :check_out_time, :board_type, :no_nights, :rate, :total_price, :currency, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
