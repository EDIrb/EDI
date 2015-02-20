class Giphy < Jarvis::Service
  phrases "gif"
  environment :giphy_api_version, :giphy_api_key
  before_invoke :build_request_url
  attr_accessor :request_url
  def run
    Jarvis.get(request_url).response["data"]["image_url"]
  end

private

  def build_request_url
    self.request_url = "#{host}#{endpoint}random?api_key=#{giphy_api_key}#{additional_params}"
  end

  def host
    "http://api.giphy.com/"
  end

  def endpoint
    "#{giphy_api_version}/gifs/"
  end

  def additional_params
    case text
    when /Cat|Kitty/i
      "&tag=cat"
    when /sloth/i
      "&tag=sloth"
    when /bacon/i
      "&tag=bacon"
    when /trippy/i
      "&tag=trippy"
    else
      ""
    end
  end
end
