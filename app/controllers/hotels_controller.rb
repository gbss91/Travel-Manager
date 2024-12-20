# Hotels Controller
class HotelsController < ApplicationController
  before_action :set_booking
  before_action :booking_confirmed?, only: :hotels

  # GET /hotels/results
  def hotels
    @hotels = HotelsApi.call(@booking.destination_city_code, @booking.adults, @booking.departure_date,
                             @booking.return_date)
  end

  # Get skeleton loading page
  def results; end

  # POST /hotels or /hotels.json
  def create
    # Remove any previous selection, in case user goes back and select a different hotel
    Hotel.delete_by(booking_id: @booking.id)

    @hotel = Hotel.new(hotel_params)
    @hotel.city = @booking.destination
    @hotel.check_in_date = @booking.departure_date
    @hotel.no_nights = (@booking.return_date - @booking.departure_date).to_i
    @hotel.total_price = @hotel.no_nights * @hotel.rate

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to confirm_booking_path(@booking) }
      else
        format.html do
          redirect_to booking_hotels_results_path(@booking), status: :unprocessable_entity,
                                                             alert: "There was an issue with the hotel,
                                                             please try again later."
        end
      end
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  # Restric certain views to only prebooked bookings
  def booking_confirmed?
    redirect_to my_bookings_path unless @booking.status == "Prebooked"
  end

  # Only allow a list of trusted parameters through.
  def hotel_params
    params.require(:hotel).permit(:booking_id, :hotel_name, :address, :room_type, :rate)
  end
end
