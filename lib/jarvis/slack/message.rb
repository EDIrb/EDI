module Slack
  class Message

    attr_accessor :text, :channel_id, :team_id, :channel_name, :user_id, :user_name, :trigger_word

    def initialize(params)
      @text = params["text"]
      @channel_id = params["channel_id"]
      @team_id = params["team_id"]
      @channel_name = params["channel_name"]
      @user_id = params["user_id"]
      @user_name = params["user_name"]
      @trigger_word = params["trigger_word"]
    end

  end
end
