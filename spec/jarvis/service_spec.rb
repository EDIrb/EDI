require 'spec_helper'

RSpec.describe Jarvis::Service do

  describe "Validate Environment Variables are Present" do

    class MyService < Jarvis::Service
      required_environment "SERVICE_TOKEN"
    end

    subject { MyService.new }

    context "Required Environment not set up" do
      it { expect { subject.validate_environment }.to raise_exception(Jarvis::UnfitEnvironmentException) }
    end

    context "Environment Correctly Set Up" do
      before { ENV["SERVICE_TOKEN"] = "token" }
      it { expect { subject.validate_environment }.to_not raise_exception }
    end

    context "Multiple Required Variables, Some not present" do
      class MyOtherService < Jarvis::Service
        required_environment "SERVICE_TOKEN", "SERVICE_SECRET"
      end
      subject { MyOtherService.new }
      before { ENV["SERVICE_TOKEN"] = "token" }
      it { expect { subject.validate_environment }.to raise_exception(Jarvis::UnfitEnvironmentException) }
    end

  end

end
