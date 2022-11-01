class Booking < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :flights
  has_many :hotels

  validates :user_id, :booked_on_date, :origin, :destination, :departure_date, :return_date, :adults, :status, :booking_type,  presence: true

end
