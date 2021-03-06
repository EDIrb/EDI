require 'spec_helper'

RSpec.describe EDI::Service do
  let(:message) { double("Slack::Message") }
  describe "Validate Environment Variables are Present" do
    before { service.environment :service_token }
    subject { service.new message }
    context "Required Environment not set up" do
      it { expect { subject.validate_environment }.to raise_exception(EDI::UnfitEnvironmentException) }
    end

    context "Environment Correctly Set Up" do
      before { stub_env("SERVICE_TOKEN" => "token") }
      it { expect { subject.validate_environment }.to_not raise_exception }
    end

    context "tries lowercase environment variable if uppercase isn't present" do
      before { service.environment :service_token }
      before { stub_env("SERVICE_TOKEN" => nil, "service_token" => "token")}
      subject { service.new message }
      it { expect { subject.validate_environment }.to_not raise_exception }
    end

    context "Multiple Required Variables, Some not present" do
      before { service.environment :service_token, :service_secret }
      before { stub_env("SERVICE_TOKEN" => "token", "SERVICE_SECRET" => nil, "service_secret" => nil) }
      it { expect { subject.validate_environment }.to raise_exception(EDI::UnfitEnvironmentException) }
    end
  end

  describe "Expose Pattern For the Service to be Interpreted" do
    before { service.interpreter_pattern /are you up/i }
    it { expect(service.pattern).to eq /are you up/i }
  end

  describe "Allow the Developer to make a list of phrases to be concatenated into the interpreter pattern" do
    context "Accepts a single phrase" do
      before { service.phrases "success kid" }
      it { expect(service.pattern ).to eq /success kid/i }
    end

    context "Multiple Phrases" do
      before { service.phrases "success kid", "hello world" }
      it { expect(service.pattern).to eq /success kid|hello world/i }

    end
  end

  describe "Environment Accessor" do
    context "Uppercase" do
      before { service.environment :service_token }
      before { stub_env("SERVICE_TOKEN" => "token") }
      subject { service.new message }
      it { expect(subject.service_token).to eq "token"}
    end
    context "Lowercase" do
      before { service.environment :service_token }
      before { stub_env("SERVICE_TOKEN" => nil, "service_token" => "token") }
      subject { service.new message }
      it { expect(subject.service_token).to eq "token"}
    end
  end

  describe "invoke_with" do
    describe "defaults to run" do
      before do
        class TestService < EDI::Service
          def run
            "Hello World"
          end
        end
      end
      it { expect(service.new(message).invoke).to eq "Hello World" }
    end

    describe "Can be overridden with #invoke_with" do
      before do
        class OtherTestService < EDI::Service
          invoke_with :call_me_maybe
          def call_me_maybe
            "This is crazy"
          end
        end
      end
      it { expect(other_service.new(message).invoke).to eq "This is crazy" }
    end

  end

  describe "before_invoke" do
    before { class TestService < EDI::Service
      before_invoke :puts_hello
      def puts_hello
        puts "Hello"
      end
    end }

    it { expect { service.new(message).invoke }.to output("Hello\n").to_stdout }
  end

  describe "after_invoke" do
    before { class TestService < EDI::Service
      after_invoke :puts_hello
      def puts_hello
        puts "Hello"
      end
    end }

    it { expect { service.new(message).invoke }.to output("Hello\n").to_stdout }
  end

end
