class BookingDecorator < BaseDecorator

  def employee(user_id)
    @user = User.find(user_id)
    "#{@user.first_name} #{@user.last_name}"
  end

  def formatted_date(date)
    date.strftime("%d %b %Y")
  end

  def total
    "€#{total_price}"
  end

end