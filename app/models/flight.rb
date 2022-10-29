class Flight < ApplicationRecord
    belongs_to :booking, dependent: :destroy

    validates :flight_no, :carrier,:origin_city, :destination_city, :departure_time, :arrival_time, :duration, :adults, :total_price, :currency, :booking_id, presence: true
end
