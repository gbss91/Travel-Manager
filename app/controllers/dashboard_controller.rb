class DashboardController < ApplicationController
  def main; end

  def insights
    @bookings = Booking.where.not(status: "Prebooked")
    @flights = Flight.joins(:booking).where.not(bookings: { status: "Prebooked" })

    @most_flights =

    @most_visited = @bookings.group_by(&:destination).max_by { |k, v| v }.first(1)[0]

    year_bookings = @bookings.where("extract(year from booked_on_date) = ?", Date.today.year).order(:booked_on_date)
    @totals = year_bookings.group_by {|b| b.booked_on_date.strftime("%B")}.map { |k, v| [k, v.each.sum(&:total_price).to_i] }
  end

end

