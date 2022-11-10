class Flight < ApplicationRecord
  belongs_to :booking

  validates :flight_no, :carrier, :origin_city, :destination_city, :departure_time, :arrival_time, :duration, :adults, :total_price, :booking_id, presence: true
end
