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
    when /(Simpsons|simpsons|Homer|homer)/
      "&source=simpsons_homer"
    when /(Star Wars|star wars|Star wars|luke|leia|vader|Vader|Luke|Leia)/
      "&source=starwars"
    else
      ""
    end
  end
end
