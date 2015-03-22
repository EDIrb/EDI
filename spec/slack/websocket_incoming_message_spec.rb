require 'spec_helper'
require 'json'

RSpec.describe Slack::WebsocketIncomingMessage do
  subject { described_class.new params }
  describe "Case Insensitive" do
    context "Lowercase" do
      let(:params) { {type: "message", text: "hello edi"}.to_json }
      it { expect(subject.mentions_edi?).to eq true }
    end

    context "uppercase" do
      let(:params) { {type: "message", text: "hello EDI"}.to_json }
      it { expect(subject.mentions_edi?).to eq true }
    end
  end

  describe "Responds when edi is followed by !" do
    let(:params) { {type: "message", text: "hello edi!"}.to_json }
    it { expect(subject.mentions_edi?).to eq true }
  end

  describe "Responds when edi is followed by ." do
    let(:params) { {type: "message", text: "hello edi."}.to_json }
    it { expect(subject.mentions_edi?).to eq true }
  end

  describe "Responds when edi is followed by ?" do
    let(:params) { {type: "message", text: "hello edi?"}.to_json }
    it { expect(subject.mentions_edi?).to eq true }
  end

  describe "Responds when edi is followed by ," do
    let(:params) { {type: "message", text: "hello edi,"}.to_json }
    it { expect(subject.mentions_edi?).to eq true }
  end

  describe "Doesn't respond when edi is part of a larger word" do
    let(:params) { {type: "message", text: "I should edit that file"}.to_json }
    it { expect(subject.mentions_edi?).to eq false }
  end
end
