class FlightsController < ApplicationController
  before_action :get_booking
  before_action :set_flight, only: [:show, :edit, :update, :destroy]

  # GET /flights or /flights.json
  def index
    @flights = @booking.flights
  end

  # GET /flights/1 or /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = @booking.flights.build
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights or /flights.json
  def create
    @flight = @booking.flights.build(flight_params)

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

  # PATCH/PUT /flights/1 or /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to  booking_flights_path(@booking) }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1 or /flights/1.json
  def destroy
    @flight.destroy

    respond_to do |format|
      format.html { redirect_to booking_flights_path(@booking)}
      format.json { head :no_content }
    end
  end

  private

    def get_booking
      @booking = Booking.find(params[:booking_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = @booking.flights.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.require(:flight).permit(:flight_no, :carrier, :origin_city, :destination_city, :departure_time, :arrival_time, :duration, :adults, :total_price, :currency, :booking_id)
    end
end
