class Weather < EDI::Service
  using ZipRefinement

  phrases "weather"
  before_invoke :determine_location
  environment :default_location # Default Location Should be a zip code
  attr_accessor :location, :zip_api_response, :temperature, :parsed_response

  def run
    self.response = EDI.get("http://api.openweathermap.org/data/2.5/weather?q=#{encoded_location}").response
    calculate_temperature
    self.response = "#{weather_description}. The temperature is currently #{temperature}"
  end

  private

  def determine_location
    self.location = if text.contains_zip?
      lookup_zip(text.zip_code)
    else
      lookup_zip(default_location)
    end
  end

  def encoded_location
    EDI.encode_uri(@location)
  end

  def lookup_zip(zip)
    zip_api_response = EDI.get("http://api.zippopotam.us/us/#{zip}").response["places"].first
    "#{zip_api_response["place name"]}, #{zip_api_response["state abbreviation"]}"
  end

  def weather_description
    self.response["weather"].first["description"].humanize
  end

  def calculate_temperature
    self.temperature = (((self.response["main"]["temp"].to_i - 273.15) * 1.8) + 32).to_i
  end

end
