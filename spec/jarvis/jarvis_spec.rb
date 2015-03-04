require 'spec_helper'

RSpec.describe Jarvis do

  describe "Service Registry" do
    it "Allows you to register a Jarvis::Service subclass" do
      Jarvis.register_services(:test_service)
      expect(Jarvis.services).to eq [:test_service]
    end
    it "Works with multiple classes" do
      Jarvis.register_services :test_service, :other_test_service
      expect(Jarvis.services).to eq [:test_service, :other_test_service]
    end
  end

  describe "Utilities" do

    it { expect(Jarvis.encode_uri("hello world")).to eq "hello%20world" }
    it { expect(Jarvis.decode_uri("hello%20world")).to eq "hello world" }
  end

  describe "Environment" do
    before { Jarvis.env = "production" }
    it { expect(Jarvis.env).to eq "production" }
    it { expect(Jarvis.env.production?).to eq true }
    it { expect(Jarvis.env.test?).to eq false }
  end

end
