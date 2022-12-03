# Decorator for Bookings. It decorates a model instance and allows to extract complex logic from the views
class BookingDecorator < BaseDecorator
  def employee(user_id)
    @user = User.find(user_id)
    "#{@user.first_name} #{@user.last_name}"
  end

  def flight_title(direction)
    if direction == "Outbound"
      "#{origin} to #{destination}"
    else
      "#{destination} to #{origin}"
    end
  end

  def total
    if status == "Round Trip"
      (flights[0].total_price + flights[1].total_price + hotel.total_price).round(2)
    else
      (flights[0].total_price + hotel.total_price).round(2)
    end
  end

  def status?
    if status == "Confirmed" && departure_date.past?
      "<td>Past Booking</td>".html_safe
    else
      "<td class='text-success'>#{status}</td>".html_safe # Returns confirm green for future reservations
    end
  end
end
