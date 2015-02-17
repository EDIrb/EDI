require 'spec_helper'

RSpec.describe Jarvis::Service do

  before(:all) do
    class MyService < Jarvis::Service
      required_environment "SERVICE_TOKEN"
    end
    class MyOtherService < Jarvis::Service
      required_environment "SERVICE_TOKEN", "SERVICE_SECRET"
    end
  end

  describe "Validate Environment Variables are Present" do
    subject { MyService.new }
    context "Required Environment not set up" do
      it { expect { subject.validate_environment }.to raise_exception(Jarvis::UnfitEnvironmentException) }
    end

    context "Environment Correctly Set Up" do
      before { ENV["SERVICE_TOKEN"] = "token" }
      it { expect { subject.validate_environment }.to_not raise_exception }
      after { ENV["SERVICE_TOKEN"] = nil }
    end

    context "Multiple Required Variables, Some not present" do
      subject { MyOtherService.new }
      before { ENV["SERVICE_TOKEN"] = "token" }
      it { expect { subject.validate_environment }.to raise_exception(Jarvis::UnfitEnvironmentException) }
      after { ENV["SERVICE_TOKEN"] = nil }
    end
  end


  after(:all) do
    # Clean Up Class Definitions
    Object.send(:remove_const, :MyService)
    Object.send(:remove_const, :MyOtherService)
  end

end
