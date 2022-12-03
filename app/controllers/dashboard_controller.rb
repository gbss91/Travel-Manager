# Main dashboard controller
class DashboardController < ApplicationController
  before_action :admin?, only: :insights

  def main; end

  def insights
    @bookings = Booking.where.not(status: "Prebooked")
    @flights = Flight.joins(:booking).where.not(bookings: { status: "Prebooked" })

    # Only set this variables is there are bookings
    return unless @bookings.length.positive?

    user_id = @bookings.group_by(&:user_id).map { |k, v| [k, v.each.sum(&:total_price).to_i] }.max_by { |_k, v| v }[0]
    @user = User.find(user_id)

    year_bookings = @bookings.where("extract(year from booked_on_date) = ?", Date.today.year).order(:booked_on_date)
    @totals = year_bookings.group_by { |b| b.booked_on_date.strftime("%B") }.map { |k, v| [k, v.each.sum(&:total_price).to_i] }
  end

  private

  def admin?
    redirect_to root_path unless current_user.admin?
  end
end
