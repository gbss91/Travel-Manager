class Hotel < ApplicationRecord
    belongs_to :booking

    validates :booking_id, presence: true, uniqueness: true
    validates :hotel_name, :city, :check_in_date, :check_in_time, :check_out_time, :no_nights, :rate, :total_price, :currency,  presence: true
end
