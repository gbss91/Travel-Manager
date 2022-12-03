# Booking observer - Observes changes in booking to remove pre-bookings
class BookingObserver < ActiveRecord::Observer
  # Destroy prebookings when user booking is updated
  def after_update(booking)
    prebookings = Booking.where(status: "Prebooked").and(Booking.where(user_id: booking.user_id))
    prebookings.each(&:destroy)
  end
end
