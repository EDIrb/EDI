require 'spec_helper'

RSpec.describe ImgFlip, vcr: { cassette_name: 'img_flip', :record => :new_episodes}  do
  before { stub_env("IMGFLIP_USER" => "imgflip_user", "IMGFLIP_PASSWORD" => "imgflip_password") }
  describe "Success Kid" do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "Jarvis, success kid hello, world")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "Here you go, DVG\n\nhttp://i.imgflip.com/hz8qk.jpg" }
  end
end
