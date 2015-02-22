module ImgFlipMemes
  class BaseMeme
    attr_accessor :message, :imgflip_user, :imgflip_password, :text0, :text1, :captures
    def initialize(message, imgflip_user, imgflip_password)
      @message = message
      @imgflip_user = imgflip_user
      @imgflip_password = imgflip_password
      @captures = {}
    end

    def tokenize
    end

    def template_id
    end

    def create_meme
      tokenize
      trim_captures
      body = {
        template_id: template_id,
        username: imgflip_user,
        password: imgflip_password,
        text0: text0,
        text1: text1
      }
      response = Jarvis.post(url, body: body).response
      unless response["success"]
        raise Jarvis::ThirdPartyAPIFailure
      else
        response["data"]["url"]
      end
    end

    def url
      "https://api.imgflip.com/caption_image"
    end

    def text0
      captures[:text0]
    end

    def text1
      captures[:text1]
    end

    def trim_captures
      self.captures[:text0] = self.captures[:text0].strip if self.captures[:text0]
      self.captures[:text1] = self.captures[:text1].strip if self.captures[:text1]
    end

    def method_missing(name, *args, &block)
      message.public_send(name, *args, &block)
    end

  end
end
