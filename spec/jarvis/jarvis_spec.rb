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

end
