Then(/^EDI will respond with an image$/) do
  expect(parsed_response(@response)).to match /jpg/
end
