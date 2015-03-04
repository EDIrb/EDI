@vcr
Feature: I Heart Quotes

  Because quotes are awesome
  As a consumer of popular culture
  I want EDI to return random quotes

  Scenario: A Random Quote
    Given a server is running with the i heart quotes service enabled
    When EDI recieves the message "EDI know any good quotes?"
    Then EDI will respond with "A random quote goes here"

  Scenario: A Simpsons Quote
    Given a server is running with the i heart quotes service enabled
    When EDI recieves the message "EDI know any good simpsons quotes?"
    Then EDI will respond with "Marge: I would love you if you weighed 1,000 pounds but ..."

  Scenario: A Star Wars Quote
    Given a server is running with the i heart quotes service enabled
    When EDI recieves the message "EDI know any good star wars quotes?"
    Then EDI will respond with "Emperor Palpatine Strike me down with all of your hatred and your journey towards the dark side will be complete!"
