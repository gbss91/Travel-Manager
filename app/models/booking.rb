class Booking < ApplicationRecord
    belongs_to :user
    has_many :flights
    has_many :hotels

    validates :user_id, :booked_on, :trip_date, :destination, :status, :total_price, :currency, :created_at, :updated_at, presence: true
end
