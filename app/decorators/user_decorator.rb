# Decorator for users. It decorates a model instance and allows to extract complex logic from the views
class UserDecorator < BaseDecorator
  def full_name
    "#{first_name} #{last_name}"
  end

  def user_role
    admin ? "Administrator" : "Staff"
  end

  def total_trips
    bookings.select { |b| b.status == "Confirmed" }.count
  end

  def total_spent
    user_bookings = bookings.select { |b| b.status == "Confirmed" }
    "€#{user_bookings.sum(&:total_price).to_i}"
  end

  def most_visited
    user_bookings = bookings.select { |b| b.status == "Confirmed" }
    user_bookings.group_by(&:destination).max_by { |k, v| v }.first(1)[0]
  end

  def next_trip
    user_bookings = bookings.select { |b| b.departure_date > Date.today && b.status == "Confirmed" }
    user_bookings.min_by(&:departure_date).destination
  end


end
