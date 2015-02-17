require 'spec_helper'

RSpec.describe Jarvis do

  describe "Service Registry" do
    before(:all) do
      class MyRegisteredService < Jarvis::Service
      end
      class MyOtherRegisteredService < Jarvis::Service
      end
    end

    it "Allows you to register a Jarvis::Service subclass" do
      Jarvis.register_services(MyRegisteredService)
      expect(Jarvis.services).to eq [MyRegisteredService]
    end

    it "Works with multiple classes" do
      Jarvis.register_services MyRegisteredService, MyOtherRegisteredService
      expect(Jarvis.services).to eq [MyRegisteredService, MyOtherRegisteredService]
    end

    after { Jarvis.clear_services }

    after(:all) do
      undefine_constant :MyRegisteredService
      undefine_constant :MyOtherRegisteredService
    end
  end

end
