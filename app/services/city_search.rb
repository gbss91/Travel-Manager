require 'http'
# Search city/airport IATA code using Amadeus API
class CitySearch < ApplicationService
  def initialize(city)
    @city = city
  end

  def call
    set_city_code
  end

  private

  def set_city_code
    # Get a new access token
    token = AmadeusAccessToken.call
    # Make call with token and params
    url = URI("https://api.amadeus.com/v1/reference-data/locations")
    response = HTTP.auth("Bearer #{token}").get(url, params: { subType: "CITY", keyword: @city, view: "LIGHT" })
    data = JSON.parse(response.body)

    # Only run if successful response
    return unless response.status.success?

    # Return nil if no outbound
    if (data["meta"]["count"]).zero?
      nil
    else
      # Return IATA Code
      data["data"][0]["iataCode"]
    end
  end
end
