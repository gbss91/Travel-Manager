class FlightsController < ApplicationController
  include ActionView::Helpers::UrlHelper
  before_action :set_booking
  before_action :booking_confirmed?, only: %i[outbound inbound]

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
        if current_page?(booking_flights_outbound_path(@booking))

          # Remove any previous selection
          Flight.delete_by(booking_id: @booking.id, origin_city: @booking.origin)

          # Save flight and redirect accordingly
          if @flight.save
            format.html { redirect_to booking_flights_inbound_path(@booking) }
          else
            format.html { redirect_to booking_flights_outbound_path(@booking), status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
          end
        else
          # Remove any previous selection
          Flight.delete_by(booking_id: @booking.id, origin_city: @booking.destination)

          #Save flight and redirect accordingly
          if @flight.save
            format.html { redirect_to booking_hotels_results_path(@booking) }
          else
            format.html { redirect_to booking_flights_outbound_path(@booking), status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
          end
        end
      else

        # Remove any previous selection
        Flight.delete_by(booking_id: @booking.id, origin_city: @booking.origin)

        # Save flight and redirect accordingly
        if @flight.save
          format.html { redirect_to booking_hotels_results_path(@booking) }
        else
          format.html { redirect_to booking_flights_outbound_path(@booking), status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
        end
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

  # Saves flight and redirect to correct path
  def save_flight(model, redirect_path)
    if model.save
      format.html { redirect_to redirect_path }
    else
      format.html { redirect_to redirect_path, status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
    end

  end

  # Only allow a list of trusted parameters through.
  def flight_params
    params.require(:flight).permit(:carrier_code, :flight_no, :carrier, :origin_city, :destination_city, :departure_time, :arrival_time, :duration, :adults, :total_price, :booking_id)
  end

end
