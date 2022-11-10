class Hotel < ApplicationRecord
  belongs_to :booking

  validates :booking_id, presence: true, uniqueness: true
  validates :hotel_name, :address, :city, :check_in_date, :no_nights, :rate, :total_price, presence: true
end
