class Booking < ApplicationRecord
  belongs_to :user
  has_many :flights, dependent: :delete_all
  has_many :hotels, dependent: :delete_all

  validates :user_id, :booked_on_date, :origin, :destination, :departure_date, :return_date, :adults, :status, :booking_type,  presence: true

end
