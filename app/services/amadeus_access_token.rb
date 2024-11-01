require 'http'
# Gets access token required to make API Call to Amadeus API
# Token needs to be requested before every call because it expires
class AmadeusAccessToken < ApplicationService
  def call
    access_token
  end

  private

  # Request access token to make API calls as per Amadeus documentation [https://developers.amadeus.com/self-service/apis-docs/guides/authorization-262]
  def access_token
    url = URI("https://api.amadeus.com/v1/security/oauth2/token")
    response = HTTP.headers(content_type: "application/x-www-form-urlencoded")
                   .post(url, form: {
                           grant_type: "client_credentials",
                           client_id: Rails.application.credentials.dig(:amadeus_pro, :api_key),
                           client_secret: Rails.application.credentials.dig(:amadeus_pro, :api_secret)
                         })
    JSON.parse(response.body)["access_token"]
  end
end
