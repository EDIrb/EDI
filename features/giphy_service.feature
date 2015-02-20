@vcr
Feature: Giphy Service
  In order to amuse my team
  As a lover of GIFs
  I want Jarvis to return random GIFs from a variety of categories

  Scenario: Plain old GIF
    Given a server is running with the giphy service enabled
    When Jarvis recieves the message "Jarvis a gif please"
    Then Jarvis will respond with "http://s3.amazonaws.com/giphymedia/media/10eqhIldgc59za/giphy.gif"

  Scenario: Cat GIF - Cat Wording
    Given a server is running with the giphy service enabled
    When Jarvis recieves the message "Jarvis a cat gif please"
    Then Jarvis will respond with "http://s3.amazonaws.com/giphymedia/media/ucEr1xRMsj6Fi/giphy.gif"

  Scenario: Cat GIF - Kitty Wording
    Given a server is running with the giphy service enabled
    When Jarvis recieves the message "Jarvis a Kitty gif please"
    Then Jarvis will respond with "http://s3.amazonaws.com/giphymedia/media/xA88mlhRVZ3lm/giphy.gif"

  Scenario: Cat GIF - Kitty Wording - Case Insensitive
    Given a server is running with the giphy service enabled
    When Jarvis recieves the message "Jarvis a KiTty gif please"
    Then Jarvis will respond with "http://s3.amazonaws.com/giphymedia/media/paYyHCsUUXQPK/giphy.gif"

  Scenario: Sloth
    Given a server is running with the giphy service enabled
    When Jarvis recieves the message "Jarvis a sloth gif please"
    Then Jarvis will respond with "http://s3.amazonaws.com/giphymedia/media/QoxeDUyerqIrC/giphy.gif"

  Scenario: Bacon
    Given a server is running with the giphy service enabled
    When Jarvis recieves the message "Jarvis a bacon gif please"
    Then Jarvis will respond with "http://s3.amazonaws.com/giphymedia/media/PJ3wMa5ImiVY4/giphy.gif"

  Scenario: Trippy
    Given a server is running with the giphy service enabled
    When Jarvis recieves the message "Jarvis a sloth gif please"
    Then Jarvis will respond with "http://s3.amazonaws.com/giphymedia/media/upNoNLqei1FVS/giphy.gif"
