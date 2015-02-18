require 'spec_helper'

RSpec.describe Jarvis::Service do

  describe "Validate Environment Variables are Present" do
    before(:all) do
      create_service("MyService")
      MyService.required_environment "SERVICE_TOKEN"
      create_service("MyOtherService")
      MyOtherService.required_environment "SERVICE_TOKEN", "SERVICE_SECRET"
    end
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
    after(:all) do
      # Clean Up Class Definitions
      undefine_constant :MyService
      undefine_constant :MyOtherService
    end
  end

  describe "Expose Pattern For the Service to be Interpreted" do
    before(:all) { create_service("MyService") }
    before { MyService.interpreter_pattern = /are you up/i }
    it { expect(MyService.interpreter_pattern).to eq /are you up/i }
    after(:all) { undefine_constant :MyService }
  end

  describe "Allow the Developer to make a list of phrases to be concatenated into the interpreter pattern" do
    before{ create_service("MyService") }

    context "Accepts a single phrase" do
      before { MyService.phrases = "success kid" }
      it { expect(MyService.interpreter_pattern).to eq /success kid/i }
    end

    context "Accepts multiple phrases" do
      before { MyService.phrases = "success kid", "hello world" }
      it { expect(MyService.interpreter_pattern).to eq /success kid|hello world/i }
    end

    after { undefine_constant :MyService }
  end


end
