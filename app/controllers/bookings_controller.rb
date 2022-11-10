class BookingsController < ApplicationController
  before_action :admin?, only: :index
  before_action :set_booking, only: %i[show confirm update destroy]

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.where.not(status: "Prebooked").order(params[:sort])
  end

  # GET /bookings for current user - Only shows future confirmed bookings in my bookings
  def current_user_bookings
    @bookings = current_user.bookings.where.not(status: "Prebooked").and(current_user.bookings.where(departure_date: Date.today..))
  end

  # GET /bookings/1 or /bookings/1.json
  # Restrict staff users to only their own bookings
  def show
    if current_user.admin?
      @booking
    elsif @booking.user_id == current_user.id
      @booking
    else
      redirect_to my_bookings_path
    end
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/confirm - Only shows for prebooked bookings
  def confirm
    redirect_to my_bookings_path unless @booking.status == "Prebooked"
  end

  # POST /bookings or /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.img_url = CityImage.call(@booking.destination)
    @booking.origin_city_code = CitySearch.call(@booking.origin)
    @booking.destination_city_code = CitySearch.call(@booking.destination)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to  booking_flights_outbound_path(@booking) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to booking_url(@booking), alert: "Booking confirmed!" }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "There was an issue confirming the booking, please try again later." }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy

    respond_to do |format|
      # Redirect admins to all bookings and staff to their own bookings
      if current_user.admin?
        format.html { redirect_to bookings_url }
        format.json { head :no_content }
      else
        format.html { redirect_to my_bookings_url }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.includes(:flights, :hotel).find(params[:id])
  end

  # Check if user is admin before performing actions
  def admin?
    redirect_to root_path unless current_user.admin?
  end

  # Only allow a list of trusted parameters through.
  def booking_params
    params.require(:booking).permit(:user_id, :booked_on_date, :origin, :destination, :departure_date, :return_date, :adults, :booking_class, :status, :total_price, :booking_type)
  end
end
