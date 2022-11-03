require "uri"
require "net/http"

class CityImage < ApplicationService

  def initialize(city)
    @city = city
  end

  def call

    #Make a call to get photo_reference
    url = URI("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=photo&input=#{@city}&inputtype=textquery&key=#{api_key}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request).read_body

    #Parse response and extract the photo_reference
    data = JSON.parse(response)
    photo_reference = data["candidates"][0]["photos"][0]["photo_reference"]

    #return the image source URL
    @city_img_url = URI("https://maps.googleapis.com/maps/api/place/photo?photo_reference=#{photo_reference}&maxheight=200&key=#{api_key}")
    return @city_img_url

  end

  private

  def api_key
    Rails.application.credentials.dig(:places_api_key)
  end

end