@vcr
Feature: ImgFlip

  Because memes are awesome
  As a consumer of popular culture
  I want EDI to return memes

  Scenario: Success Kid
    Given a server is running with the img flip service enabled
    When EDI recieves the message "EDI success kid testing edi, it works"
    Then EDI will respond with an image
