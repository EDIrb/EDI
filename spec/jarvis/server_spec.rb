require 'spec_helper'

RSpec.describe Jarvis::Server do
  let(:parsed_response) { JSON.parse(last_response.body) }
  let(:message) { parsed_response["text"] }
  describe "get /" do
    before { get "/" }
    it { expect(last_response).to be_ok }
    it { expect(message).to eq "Hello, I'm Jarvis" }
  end

  describe "unfit environment" do
    let(:slack_message) { slack_outgoing_message(text: "Jarvis, success kid blah blah blah") }
    before { service.environment :blah }
    before { service.phrases = "success kid" }
    before { Jarvis.register_services :test_service }
    before { post "/jarvis", slack_message }
    it { expect(message).to eq "I'm really sorry, but that sevice needs to be configured" }
  end
end
