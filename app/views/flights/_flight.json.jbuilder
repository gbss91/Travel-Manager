json.extract! flight, :id, :flight_no, :carrier, :origin_city, :destination_city, :departure_time, :arrival_time, :duration, :adults, :total_price, :currency, :created_at, :updated_at
json.url flight_url(flight, format: :json)
