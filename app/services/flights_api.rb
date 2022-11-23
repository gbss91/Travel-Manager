require 'http'
# Search flights using Amadeus API
class FlightsApi < ApplicationService
  def initialize(origin_city, destination_city, adults, departure_date, travel_class)
    @origin_city = origin_city
    @destination_city = destination_city
    @adults = adults
    @departure_date = departure_date
    @travel_class = travel_class
  end

  def call
    # Get a new access token - Will be used for all calls
    @token = AmadeusAccessToken.call

    # Find flights in API
    data = find_flights

    # Extract data
    flights = extract_data(data)

    # Return flights empty array if no results, else continue with airline search
    return flights unless flights.length.positive?

    flights.each do |f|
      airline = find_arline(f.carrier_code)
      f.carrier = airline
    end

    # Return flights
    flights.sort_by(&:departure_time)

  end

  private

  def find_flights
    # Make call with token and params
    url = URI("https://test.api.amadeus.com/v2/shopping/flight-offers")
    response = HTTP.auth("Bearer #{@token}").get(url, params: { originLocationCode: @origin_city, destinationLocationCode: @destination_city, departureDate: @departure_date.to_s, adults: @adults, travelClass: @travel_class, currencyCode: "EUR", nonStop: true, max: 10 })

    return unless response.status.success?

    # Return response body if success
    JSON.parse(response.body)
  end

  def extract_data(data)
    flight_results = []

    return flight_results if data.nil?

    data["data"].each do |f|
      flight = Flight.new
      flight.carrier_code = f["itineraries"][0]["segments"][0]["carrierCode"]
      flight.flight_no = f["itineraries"][0]["segments"][0]["number"]
      flight.origin_city = f["itineraries"][0]["segments"][0]["departure"]["iataCode"]
      flight.departure_time = f["itineraries"][0]["segments"][0]["departure"]["at"]
      flight.destination_city = f["itineraries"][0]["segments"][0]["arrival"]["iataCode"]
      flight.arrival_time = f["itineraries"][0]["segments"][0]["arrival"]["at"]
      flight.adults = @adults
      flight.total_price = f["price"]["grandTotal"].to_i.round()
      flight.duration = f["itineraries"][0]["segments"][0]["duration"]

      flight_results << flight
    end

    # Return results
    flight_results
  end

  def find_arline(carrier_code)
    sleep(0.5.second) # Used in development to avoid reaching API rate limit

    # Make call with token and params
    url = URI("https://test.api.amadeus.com/v1/reference-data/airlines")
    response = HTTP.auth("Bearer #{@token}").get(url, params: { airlineCodes: carrier_code })

    # Return carrier code if error, else airline name
    return carrier_code unless response.status.success?

    JSON.parse(response.body)["data"][0]["businessName"].titleize

  end
end
