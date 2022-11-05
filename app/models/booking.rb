class Booking < ApplicationRecord
  belongs_to :user
  has_many :flights, dependent: :delete_all
  has_many :hotels, dependent: :delete_all

  validates :user_id, :booked_on_date, :origin, :destination, :departure_date, :return_date, :adults, :status, :booking_type,  presence: true,  allow_blank: false
  validate :origin_code
  validate :destination_code

  private

  def origin_code
    errors.add(:base, "Cannot find departure city") if origin_city_code.nil?
  end

  def destination_code
    errors.add(:base, "Cannot find destination city") if destination_city_code.nil?
  end

end
