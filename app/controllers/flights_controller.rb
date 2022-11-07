class FlightsController < ApplicationController
  before_action :get_booking


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
      if @flight.save
        format.html { redirect_to  booking_flights_path(@booking)}
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1 or /flights/1.json
  def destroy
    @flight.destroy
  end

  private

    def get_booking
      @booking = Booking.find(params[:booking_id])
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.permit(:flight_no, :carrier, :origin_city, :destination_city, :departure_time, :arrival_time, :duration, :adults, :total_price, :booking_id)
    end
end
