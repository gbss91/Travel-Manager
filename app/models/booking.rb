class Booking < ApplicationRecord
    belongs_to :user
    has_many :flights
    has_many :hotels
end
