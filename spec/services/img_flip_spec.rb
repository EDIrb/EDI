require 'spec_helper'

RSpec.describe ImgFlip  do
  # before { stub_env("IMGFLIP_USER" => "imgflip_user", "IMGFLIP_PASSWORD" => "imgflip_password") }
  describe "Success Kid", vcr: { cassette_name: 'img_flip_success_kid', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, success kid hello, world")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hz9zo.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Afraid to Ask Andy", vcr: { cassette_name: 'img_flip_afraid_to_ask', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, I'm not sure how to mock third party apis, and at this point, I'm afraid to ask")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hza6u.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "And It's Gone", vcr: { cassette_name: 'img_flip_and_its_gone', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, you have some services here, and it's gone")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzqv7.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Everywhere", vcr: { cassette_name: 'img_flip_everywhere', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, tests, tests everywhere")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzr5m.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Everywhere", vcr: { cassette_name: 'img_flip_gonna_have_a_bad_time', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, if you mock when you should use a real object, you're gonna have a bad time")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzrd1.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Most Interesting Man", vcr: { cassette_name: 'img_flip_most_interesting_man', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, I don't always ci my code, but when I do, I do it on Travis")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzrnq.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Not Sure If", vcr: { cassette_name: 'img_flip_not_sure_if', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, Not sure if this test is going to pass, or if it's gonna break the build")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzrz0.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "One Does Not Simply", vcr: { cassette_name: 'img_flip_one_does_not_simply', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, one does not simply write rspecs")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzs4e.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Overly Attached Girlfriend", vcr: { cassette_name: 'img_flip_overly_attached_girlfriend', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, overly attached girlfriend I looked at your slack channel, who is this jarvis you keep talking to?")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzsbu.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Picard", vcr: { cassette_name: 'img_flip_picard', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, picard why the fuck, did you make so many memes?")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzsgd.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Sudden Clarity", vcr: { cassette_name: 'img_flip_sudden_clarity', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, sudden clarity can't think of, anything clever right now")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzspk.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "What if I Told You", vcr: { cassette_name: 'img_flip_what_if_I_told_you', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI, what if I told you EDI is the best bot ever?")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzsv9.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Willy Wonka", vcr: { cassette_name: 'img_flip_willy_wonka', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI willy wonka hello, world")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzt18.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
  describe "Y U No", vcr: { cassette_name: 'img_flip_y_u_no', :record => :new_episodes} do
    let(:message) { Slack::Message.new(slack_outgoing_message(user_name: "DVG", text: "EDI y u no sql")) }
    subject { described_class.new message }
    let(:meme_link) { "http://i.imgflip.com/hzt5g.jpg" }
    it { expect(subject.invoke).to eq "#{meme_link}" }
  end
end
