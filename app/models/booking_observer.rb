class BookingObserver < ActiveRecord::Observer

  # Destroy prebookings when user booking is updated
  def after_update(booking)
    prebookings = Booking.where(status: "Prebooked").and(Booking.where(user_id: booking.user_id))
    prebookings.each do |b|
      b.destroy
    end
  end

end
