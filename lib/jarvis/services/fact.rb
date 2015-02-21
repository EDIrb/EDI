class Fact < Jarvis::Service
  phrases "fact"

  def run
    Jarvis.get("http://numbersapi.com/random").unparsed_response
  end
end
