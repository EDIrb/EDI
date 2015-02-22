@vcr

Feature: Weather Service

Because I live in the midwest
As a person who doesn't want to get rained on
I want Jarvis to tell me if I need an umbrella

  Background:
    Given a default location of 43240

  Scenario: Use default location
    Given a server is running with the weather service enabled
    When Jarvis recieves the message "Jarvis what's the weather like?"
    Then Jarvis will respond with "Light rain. The temperature is currently 38"


  Scenario: Use a specified location
    Given a server is running with the weather service enabled
    When Jarvis recieves the message "Jarvis what's the weather like in 90210?"
    Then Jarvis will respond with "Broken clouds. The temperature is currently 51"
