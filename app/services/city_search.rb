require 'http'

#Search city/airport IATA code using Amadeus API

class CitySearch < ApplicationService

  def initialize(city)
    @city = city
  end

  def call
    get_city_code
  end

  private

  def get_city_code
    #Get a new access token
    token = AmadeusAccessToken.call
    #Make call with token and params
    url = URI("https://test.api.amadeus.com/v1/reference-data/locations")
    response = HTTP.auth("Bearer #{token}").get(url, params: {subType: "CITY", keyword: @city, view: "LIGHT"})
    data = JSON.parse(response.body)


    #Only run if successful response
    if response.status.success?
      #Return nil if no results
      if data["meta"]["count"] == 0
        nil
      else
        #return IATA Code
        data["data"][0]["iataCode"]
      end
    else
      nil
    end
  end

end