require 'spec_helper'

RSpec.describe Jarvis::Interpreter do

  describe "Routes Services based on the registered services interpreter patterns" do
    before { service.phrases = "success kid" }
    before { Jarvis.register_services :test_service }
    context "A Match" do
      subject { described_class.new("success kid") }
      it { expect(subject.determine_service).to eq service }
    end
    context "No Match" do
      subject { described_class.new("blah") }
      it { expect(subject.determine_service).to be_nil }
    end
  end
end
