require "http"

# Gets hotel in city
# Two calls required as per Amadeus API: one gets the hotel list with ids, the second gets hotel details and rate
# Once call to Google's Geocoder to get full address of hotel using coordinates returned by Amadeus
class HotelsApi < ApplicationService
  def initialize(city_code, adults, check_in, check_out)
    @city_code = city_code
    @adults = adults
    @check_in = check_in
    @check_out = check_out
  end

  def call
    # Get a new access token - Will be used for both calls
    token = AmadeusAccessToken.call

    # Get hotelID list
    hotel_ids = find_hotel_ids(token)

    return unless hotel_ids.length.positive?

    # Get hotel details if previous call has results
    data = find_hotel_details(token, hotel_ids)
    hotels = extract_data(data)

    # Get actual address with coordinates and add it to hash
    hotels.each do |hotel|
      address = find_hotel_address(hotel[:hotel_geocode])
      hotel[:address] = address
    end

    # Return hotels with address
    hotels
  end

  private

  def find_hotel_ids(token)
    # Make call with token and params
    url = URI("https://test.api.amadeus.com/v1/reference-data/locations/hotels/by-city")
    response = HTTP.auth("Bearer #{token}").get(url, params: { cityCode: @city_code, radius: 5 })
    data = JSON.parse(response.body)

    # Array to store all hotel Ids
    hotel_ids = []

    return hotel_ids unless response.status.success?

    # Take only  first 15 hotels in data to avoid reaching free monthly quota
    data["data"].slice(0, 15).each do |hotel|
      hotel_ids << hotel["hotelId"]
    end

    # Return hotel list with Ids
    hotel_ids
  end

  def find_hotel_details(token, hotel_ids)
    # Make call with token and params
    url = URI("https://test.api.amadeus.com/v3/shopping/hotel-offers")
    response = HTTP.auth("Bearer #{token}").get(url, params: { hotelIds: hotel_ids, adults: @adults, checkInDate: @check_in.to_s, checkOutDate: @check_out.to_s })

    return unless response.status.success?

    # Return response body if success
    JSON.parse(response.body)
  end

  def extract_data(data)
    hotel_list = []

    return hotel_list if data.nil?

    data["data"].each do |hotel|
      hotel_details = {
        hotel_name: hotel["hotel"]["name"],
        hotel_geocode: "#{hotel['hotel']['latitude']},#{hotel['hotel']['longitude']}",
        room_type: hotel["offers"][0]["room"]["typeEstimated"]["category"],
        rate: hotel["offers"][0]["price"]["total"]
      }
      hotel_list << hotel_details
    end
    hotel_list
  end

  def find_hotel_address(geocode)
    # Make a call to Google's Geocode API
    url = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{geocode}&key=#{api_key}")
    response = HTTP.get(url)
    data = JSON.parse(response.body)
    data["results"][0]["formatted_address"]
  end

  def api_key
    Rails.application.credentials[:places_api_key]
  end
end
