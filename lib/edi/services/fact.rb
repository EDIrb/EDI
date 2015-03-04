class Fact < EDI::Service
  phrases "fact"

  def run
    EDI.get("http://numbersapi.com/random").unparsed_response
  end
end
