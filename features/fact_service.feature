@vcr
Feature: Fact Service

Scenario: EDI responds with a random fact
  Given a server is running with the fact service enabled
  When EDI recieves the message "EDI. fact"
  Then EDI will respond with "38 is the number of minutes in the shortest war in history in which Zanzibar surrendered to England in 1896."
