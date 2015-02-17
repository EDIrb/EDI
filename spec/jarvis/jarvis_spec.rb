require 'spec_helper'

RSpec.describe Jarvis do

  describe "Service Registry" do
    it "Allows you to register a Jarvis::Service subclass" do
      class MyRegisteredService < Jarvis::Service
      end
      Jarvis.register(MyRegisteredService)
      expect(Jarvis.services).to eq [MyRegisteredService]
    end
  end

end
