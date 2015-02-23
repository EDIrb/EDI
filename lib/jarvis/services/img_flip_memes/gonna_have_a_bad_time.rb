module ImgFlipMemes
  class GonnaHaveABadTime < BaseMeme
    def template_id
      100951
    end

    def text1
      "You're gonna have a bad time"
    end

    def tokenize
      captures = text.match(/#{trigger_word},? (?<text0>.+),? you're gonna have a bad time/i)
      self.captures[:text0] = captures[:text0]
      true
    end
  end
end
