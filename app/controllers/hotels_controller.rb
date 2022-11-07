class HotelsController < ApplicationController
  before_action :get_booking


  # GET /hotels/outbound
  def results
    @hotels = HotelsApi.call(@booking.destination_city_code, @booking.adults, @booking.departure_date, @booking.return_date)
  end


  # POST /hotels or /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.city = @booking.destination
    @hotel.check_in_date = @booking.departure_date
    @hotel.no_nights = (@booking.return_date - @booking.departure_date).to_i
    @hotel.total_price = @hotel.no_nights * @hotel.rate

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to  booking_path(@booking)}
      else
        format.html { redirect_to booking_hotels_results_path(@booking), status: :unprocessable_entity }
      end
    end
  end

  private

    def get_booking
      @booking = Booking.find(params[:booking_id])
    end

    # Only allow a list of trusted parameters through.
    def hotel_params
      params.permit(:booking_id, :hotel_name, :address, :room_type, :rate)
    end

end
