require "http"

#Gets hotel in city
# Two calls required as per Amadeus API: one gets the hotel list with ids, the second gets hotel details and rate

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

    #Get hotel list
    hotel_list = get_hotel_list(token)

    #Get hotel details if any results from previous call
    if hotel_list.length > 0
      get_hotel_details(token, hotel_list)
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
      #Extract the first 20 hotels in data to avoid reaching free calls monthly quota - This can be changed to extract all results
      for i in 1..20 do
        hotel_list << data["data"][i]["hotelId"]
      end
    end

    #Return hotel list with Ids
    hotel_list
  end

  def get_hotel_details(token, hotel_ids)
    puts hotel_ids
    #Make call with token and params
    url = URI("https://test.api.amadeus.com/v3/shopping/hotel-offers")
    response = HTTP.auth("Bearer #{token}").get(url, params: {hotelIds: hotel_ids, adults: @adults, checkInDate: @check_in, checkOutDate: @check_out})
    data = JSON.parse(response.body)
    puts data

    hotel_list = []

    if response.status.success?
      #Iterate over data and put data into hash and add to hotel_list
      data["data"].each do |hotel|
        hotel_details = {
          hotel_name: hotel["hotel"]["name"],
          room_type: hotel["offers"][0]["room"]["typeEstimated"]["category"],
          rate: hotel["offers"][0]["price"]["total"],
          currency: hotel["offers"][0]["price"]["currency"]
        }
        hotel_list << hotel_details
      end
    end

    #return hotel list with details
    hotel_list

  end

end