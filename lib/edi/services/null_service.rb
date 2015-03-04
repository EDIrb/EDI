class NullService < EDI::Service
  def run
    EDI::ArrayResponder.new(EDI.config.default_response).respond
  end
end
