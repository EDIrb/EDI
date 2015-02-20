class Fact < Jarvis::Service
  self.phrases = "fact"

  def run
    Jarvis.get("http://numbersapi.com/random").parsed_response
  end
end
