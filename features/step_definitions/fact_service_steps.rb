When(/^EDI recieves the message "(.*?)"$/) do |message|
  @response = post("/edi", slack_outgoing_message(text: message))
end

Then(/^EDI will respond with "(.*?)"$/) do |message|
  expect(parsed_response(@response)).to eq message
end
