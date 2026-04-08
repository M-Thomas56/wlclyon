require "open-uri"

class Place < ApplicationRecord
  before_save :geocode_address, if: :address_changed?

  belongs_to :user
  belongs_to :category

  def geocode_address
    url = "https://nominatim.openstreetmap.org/search?q=#{URI.encode_www_form_component(address)}&format=json&limit=1"
    response = JSON.parse(URI.open(url, "User-Agent" => "wlclyon/1.0").read)
    if response.any?
      self.latitude  = response[0]["lat"].to_f
      self.longitude = response[0]["lon"].to_f
    end
  end
end
