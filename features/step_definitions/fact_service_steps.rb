Given(/^a server is running with the (.+) service enabled$/) do |service|
  Jarvis.register_services service.to_sym
end

When(/^Jarvis recieves the message "(.*?)"$/) do |message|
  VCR.use_cassette("fact") do
    @response = post("/jarvis", slack_outgoing_message(text: message))
  end
end

Then(/^Jarvis will respond with "(.*?)"$/) do |message|
  expect(parsed_response(@response)).to eq message
end
