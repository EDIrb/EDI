require 'spec_helper'

RSpec.describe EDI do

  describe "Service Registry" do
    it "Allows you to register a EDI::Service subclass" do
      EDI.register_services(:test_service)
      expect(EDI.services).to eq [:test_service]
    end
    it "Works with multiple classes" do
      EDI.register_services :test_service, :other_test_service
      expect(EDI.services).to eq [:test_service, :other_test_service]
    end
  end

  describe "Utilities" do

    it { expect(EDI.encode_uri("hello world")).to eq "hello%20world" }
    it { expect(EDI.decode_uri("hello%20world")).to eq "hello world" }
  end

  describe "Environment" do
    before { EDI.env = "production" }
    it { expect(EDI.env).to eq "production" }
    it { expect(EDI.env.production?).to eq true }
    it { expect(EDI.env.test?).to eq false }
  end

end
