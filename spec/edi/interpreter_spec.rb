require 'spec_helper'

RSpec.describe EDI::Interpreter do
  def message(params)
    Slack::Message.new(slack_outgoing_message(params))
  end

  describe "Defaults to NullService" do
    before { EDI.register_services :test_service }
    subject { described_class.new(message text: "success kid") }
    it { expect(subject.determine_service).to eq NullService }
  end

  describe "Routes Services based on the registered services phrases" do
    before { service.phrases "success kid" }
    before { EDI.register_services :test_service }
    context "A Match" do
      subject { described_class.new(message text: "success kid") }
      it { expect(subject.determine_service).to eq service }
    end
    context "No Match" do
      subject { described_class.new(message text: "blah") }
      it { expect(subject.determine_service).to eq NullService }
    end
    context "Generated regex is case insensitive" do
      subject { described_class.new(message text: "SUCCESS KID") }
      it { expect(subject.determine_service).to eq service}
    end
    context "Multiple phrases route correctly" do
      before(:each) { other_service.phrases "overly attached bot", "hello world" }
      before { EDI.register_services :other_test_service }
      it { expect(described_class.new(message text: "hello world").determine_service).to eq other_service }
      it { expect(described_class.new(message text: "overly attached bot").determine_service).to eq other_service }
    end
  end

  describe "Routes services based on the registered interpreter pattern" do
    before { service.interpreter_pattern /success kid/i }
    before { EDI.register_services :test_service }
    context "A Match" do
      subject { described_class.new(message text: "success kid") }
      it { expect(subject.determine_service).to eq service }
    end
    context "No Match" do
      subject { described_class.new(message text: "blah") }
      it { expect(subject.determine_service).to eq NullService }
    end
  end

  describe "Routes to the correct service" do
    let(:correct_service) { service }
    let(:incorrect_service) { other_service }
    before { correct_service.interpreter_pattern /success kid/i }
    before { incorrect_service.interpreter_pattern /overly attached chatbot/i }
    before { EDI.register_services :test_service, :other_test_service }
    context "Routes to Test Service" do
      subject { described_class.new(message text: "success kid hello, world") }
      it { expect(subject.determine_service).to eq correct_service }
    end
  end
end
