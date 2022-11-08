class FlightsController < ApplicationController
  include ActionView::Helpers::UrlHelper
  before_action :get_booking
  before_action :is_confirmed, only: [:outbound, :inbound]

  # GET /flights/outbound
  def outbound
    @flights = [{:ID => "Hello"}]
  end

  # GET /flights/inbound
  def inbound
    @flights = [{:ID => "Hello"}]
  end

  # POST /flights or /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|

      #If round trip, redirect to inbound flight results
      if current_page?(booking_flights_outbound_path(@booking)) || @booking.booking_type == "Round Trip"
        if @flight.save
          format.html { redirect_to booking_flights_inbound_path(@booking)}
        else
          format.html { redirect_to booking_flights_outbound_path(@booking), status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
        end
      else
        if @flight.save
          format.html { redirect_to booking_hotels_results_path(@booking)}
        else
          format.html { redirect_to booking_flights_inbound_path(@booking), status: :unprocessable_entity, alert: "There was an issue with the flight, please try again later." }
        end
      end
    end
  end

  private

    def get_booking
      @booking = Booking.find(params[:booking_id])
    end

    #Restric certain views to only prebooked bookings
    def is_confirmed
      redirect_to my_bookings_path unless @booking.status == "Prebooked"
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.permit(:flight_no, :carrier, :origin_city, :destination_city, :departure_time, :arrival_time, :duration, :adults, :total_price, :booking_id)
    end
end
