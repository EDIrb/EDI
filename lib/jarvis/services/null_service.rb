class NullService < Jarvis::Service
  def run
    responses.sample
  end

private

  def responses
    case Jarvis.config.default_response
    when String then [Jarvis.config.default_response]
    when Array then Jarvis.config.default_response
    end
  end
end
