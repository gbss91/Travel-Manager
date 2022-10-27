class Hotel < ApplicationRecord
    belongs_to :booking

    validates :booking_id, :hotel_name, :city, :check_in_date, :check_in_time, :check_out_time, :no_nights, :rate, :total_price, :currency, :created_at, :updated_at,  presence: true
end
