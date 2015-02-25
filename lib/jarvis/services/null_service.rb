class NullService < Jarvis::Service
  def run
    Jarvis::ArrayResponder.new(Jarvis.config.default_response).respond
  end
end
