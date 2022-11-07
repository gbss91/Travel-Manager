require "http"

#Gets hotel in city
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

    #Get a new access token - Will be used for both calls
    token = AmadeusAccessToken.call

    #Get hotelID list
    hotel_list = get_hotel_list(token)

    #Get hotel details if outbound from previous call
    if hotel_list.length > 0

      hotels = get_hotel_details(token, hotel_list)

      hotels.each do |hotel|

        #Get actual address with coordinates and add it to hash
        address = get_hotel_address(hotel[:hotel_geocode])
        hotel[:address] = address
      end

      #Return hotels with address
      hotels
    else
      nil
    end

  end

  private

    def get_hotel_list(token)
      #Make call with token and params
      url = URI("https://test.api.amadeus.com/v1/reference-data/locations/hotels/by-city")
      response = HTTP.auth("Bearer #{token}").get(url, params: {cityCode: @city_code, radius: 5})
      data = JSON.parse(response.body)

      #Array to store all hotel Ids
      hotel_list = []

      if response.status.success?
        #Extract the first 15 hotels in data to avoid reaching free monthly quota -  If less than 15 hotels, extract all
        if data["data"].length >= 15
          for i in 1..15 do
            hotel_list << data["data"][i]["hotelId"]
          end
        else
          data["data"].each do |hotel|
            hotel_list << hotel["hotelId"]
          end
        end
      end

      #Return hotel list with Ids
      hotel_list
    end

    def get_hotel_details(token, hotel_ids)

      #Make call with token and params
      url = URI("https://test.api.amadeus.com/v3/shopping/hotel-offers")
      response = HTTP.auth("Bearer #{token}").get(url, params: {hotelIds: hotel_ids, adults: @adults, checkInDate: @check_in.to_s, checkOutDate: @check_out.to_s})
      data = JSON.parse(response.body)

      hotel_list = []

      if response.status.success?
        #Iterate over data and put data into hash and add to hotel_list
        data["data"].each do |hotel|
          hotel_details = {
            hotel_name: hotel["hotel"]["name"],
            hotel_geocode: "#{hotel["hotel"]["latitude"]},#{hotel["hotel"]["longitude"]}",
            room_type: hotel["offers"][0]["room"]["typeEstimated"]["category"],
            rate: hotel["offers"][0]["price"]["total"]
          }
          hotel_list << hotel_details
        end
      end

      #return hotel list with details
      hotel_list

    end

  def get_hotel_address(geocode)

    #Make a call to Google's Geocode API
    url = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{geocode}&key=#{api_key}")
    response = HTTP.get(url)
    data = JSON.parse(response.body)
    data["results"][0]["formatted_address"]
  end

  def api_key
    Rails.application.credentials.dig(:places_api_key)
  end

end