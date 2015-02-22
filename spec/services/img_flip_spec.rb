require 'spec_helper'

RSpec.describe ImgFlip  do
  before { stub_env("IMGFLIP_USER" => "imgflip_user", "IMGFLIP_PASSWORD" => "imgflip_password") }
  describe "Success Kid", vcr: { cassette_name: 'img_flip_success_kid', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "Jarvis, success kid hello, world")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hz9zo.jpg" }
    it { expect(subject.invoke).to eq "Here you go, DVG\n\n#{meme_link}" }
  end
  describe "Afraid to Ask Andy", vcr: { cassette_name: 'img_flip_afraid_to_ask', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "Jarvis, I'm not sure how to mock third party apis, and at this point, I'm afraid to ask")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hza6u.jpg" }
    it { expect(subject.invoke).to eq "Here you go, DVG\n\n#{meme_link}" }
  end
end
