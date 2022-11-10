require "http"
# Gets city image from Google Places API
class CityImage < ApplicationService
  def initialize(city)
    @city = city
  end

  def call
    set_img
  end

  private

  def set_img

    # Make a call to get photo_reference
    url = URI("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=photo&input=#{@city}&inputtype=textquery&key=#{api_key}")
    response = HTTP.get(url)
    data = JSON.parse(response.body)

    # Only run if successful response
    if response.status.success?
      # Return nil if no outbound or no photo reference
      if data["candidates"].empty? || data["candidates"][0].empty?
        nil
      else
        photo_reference = data["candidates"][0]["photos"][0]["photo_reference"]

        # Return the image source URL
        URI("https://maps.googleapis.com/maps/api/place/photo?photo_reference=#{photo_reference}&maxheight=200&key=#{api_key}")
      end
    end

  end

  def api_key
    Rails.application.credentials[:places_api_key]
  end
end
