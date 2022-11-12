class FlightsController < ApplicationController
  include ActionView::Helpers::UrlHelper
  before_action :set_booking
  before_action :booking_confirmed?, only: %i[outbound inbound]
  before_action :round_trip?, only: :inbound

  # GET /flights/outbound
  def outbound
    @flights = FlightsApi.call(@booking.origin_city_code, @booking.destination_city_code, @booking.adults, @booking.departure_date, @booking.booking_class)
  end

  # GET /flights/inbound
  def inbound
    @flights = FlightsApi.call(@booking.destination_city_code, @booking.origin_city_code, @booking.adults, @booking.return_date, @booking.booking_class)
  end

  # POST /flights or /flights.json
  def create
    @flight = Flight.new(flight_params)
    respond_to do |format|
      if @booking.booking_type == "Round Trip"
        if @flight.origin_city == @booking.origin_city_code # Outbound flight
          save_outbound(format)
        else
          save_inbound(format)
        end
      else
        save_inbound_oneway(format)
      end
    end

  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  # Restrict certain views to only prebooked bookings
  def booking_confirmed?
    redirect_to my_bookings_path unless @booking.status == "Prebooked"
  end

  # Restrict outbound view to only round trips
  def round_trip?
    redirect_to booking_flights_outbound_path unless @booking.booking_type == "Round Trip"
  end

  def save_outbound(format)
    # Remove any previous selection
    Flight.delete_by(booking_id: @booking.id, origin_city: @flight.origin_city)

    # Save flight and redirect accordingly
    if @flight.save
      format.html { redirect_to booking_flights_inbound_path(@booking) }
    else
      format.html { redirect_to booking_flights_outbound_path(@booking), status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
    end
  end

  def save_inbound(format)
    # Remove any previous selection
    Flight.delete_by(booking_id: @booking.id, origin_city: @flight.origin_city)

    # Save flight and redirect accordingly
    if @flight.save
      format.html { redirect_to booking_hotels_results_path(@booking) }
    else
      format.html { redirect_to booking_flights_inbound_path(@booking), status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
    end
  end

  def save_inbound_oneway(format)
    # Remove any previous selection
    Flight.delete_by(booking_id: @booking.id, origin_city: @flight.origin_city)

    # Save flight and redirect accordingly
    if @flight.save
      format.html { redirect_to booking_hotels_results_path(@booking) }
    else
      format.html { redirect_to booking_flights_outbound_path(@booking), status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
    end
  end

  # Only allow a list of trusted parameters through.
  def flight_params
    params.require(:flight).permit(:carrier_code, :flight_no, :carrier, :origin_city, :destination_city, :departure_time, :arrival_time, :duration, :adults, :total_price, :booking_id)
  end

end
