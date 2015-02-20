When(/^Jarvis recieves the message "(.*?)"$/) do |message|
  @response = post("/jarvis", slack_outgoing_message(text: message))
end

Then(/^Jarvis will respond with "(.*?)"$/) do |message|
  expect(parsed_response(@response)).to eq message
end
