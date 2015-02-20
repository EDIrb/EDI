@vcr
Feature: Fact Service

Scenario: Jarvis responds with a random fact
  Given a server is running with the fact service enabled
  When Jarvis recieves the message "Jarvis. fact"
  Then Jarvis will respond with "536 is the number of ways to arrange the pieces of the stomachion puzzle into a square."
