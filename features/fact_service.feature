Feature: Fact Service

Scenario: Jarvis responds with a random fact
  Given a server is running with the fact service enabled
  When Jarvis recieves the message "Jarvis. fact"
  Then Jarvis will respond with "182 is the carat of the Star of Bombay cabochon-cut star sapphire originating from Sri Lanka."
