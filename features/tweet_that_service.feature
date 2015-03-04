@vcr
Feature: Tweet that

Because stuff with no context is funny
As a twitter user
I want EDI to post the last message to twitter

  Background:
    Given the Tweet That is configured

  Scenario: Post the last message to twitter
    Given a server is running with the tweet that service enabled
    When the user DVG post a message to the general channel saying "EDI, tweet that"
    Then EDI will respond with "Here you are, DVG, https://twitter.com/twitter_handle/status/569329768350380032"
