class IHeartQuotes < Jarvis::Service
  phrases "quote"
  after_invoke :extract_quote

  def run
    Jarvis.get(request_url).response
  end

private

  def extract_quote
    self.response = self.response["quote"].strip
  end

  def request_url
    "http://iheartquotes.com/api/v1/random?format=json#{source}"
  end

  def source
    case text
    when /simpsons|homer/i
      "&source=simpsons_homer"
    when /star wars|luke|leia|vader/i
      "&source=starwars"
    else
      ""
    end
  end
end
