require 'spec_helper'

RSpec.describe Jarvis::Service do

  describe "Validate Environment Variables are Present" do
    before { service.required_environment "SERVICE_TOKEN" }
    subject { service.new }
    context "Required Environment not set up" do
      it { expect { subject.validate_environment }.to raise_exception(Jarvis::UnfitEnvironmentException) }
    end

    context "Environment Correctly Set Up" do
      before { ENV["SERVICE_TOKEN"] = "token" }
      it { expect { subject.validate_environment }.to_not raise_exception }
      after { ENV["SERVICE_TOKEN"] = nil }
    end

    context "Multiple Required Variables, Some not present" do
      before { service.required_environment "SERVICE_TOKEN", "SERVICE_SECRET" }
      before { ENV["SERVICE_TOKEN"] = "token" }
      it { expect { subject.validate_environment }.to raise_exception(Jarvis::UnfitEnvironmentException) }
      after { ENV["SERVICE_TOKEN"] = nil }
    end
  end

  describe "Expose Pattern For the Service to be Interpreted" do
    before { service.interpreter_pattern = /are you up/i }
    it { expect(service.interpreter_pattern).to eq /are you up/i }
  end

  describe "Allow the Developer to make a list of phrases to be concatenated into the interpreter pattern" do
    context "Accepts a single phrase" do
      before { service.phrases = "success kid" }
      it { expect(service.interpreter_pattern ).to eq /success kid/i }
    end

    context "Multiple Phrases" do
      before { service.phrases = "success kid", "hello world" }
      it { expect(service.interpreter_pattern).to eq /success kid|hello world/i }

    end
  end


end
