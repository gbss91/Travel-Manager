class BookingDecorator < BaseDecorator

  def employee(user_id)
    @user = User.find(user_id)
    "#{@user.first_name} #{@user.last_name}"
  end

  def formatted_date(date)
    date.strftime("%d %b %Y")
  end

  def total
    "EUR#{total_price}"
  end

  def status?
    if status == "Confirmed" && departure_date.past?
      ("<td>Past Booking</td>").html_safe
    else
      ("<td class='text-success'>#{status}</td>").html_safe #Returns confirm green for future reservations
    end
  end

end