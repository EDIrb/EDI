require 'spec_helper'

RSpec.describe Jarvis::Server do
  let(:parsed_response) { JSON.parse(last_response.body) }

  describe "get /" do
    before { get "/" }
    it { expect(last_response).to be_ok }
    it { expect(parsed_response["text"]).to eq "Hello, I'm Jarvis" }
  end
end
