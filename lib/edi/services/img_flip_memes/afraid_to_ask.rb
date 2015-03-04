module ImgFlipMemes
  class AfraidToAsk < BaseMeme
    def template_id
      24557067
    end

    def text1
      "And at this point, I'm afraid to ask"
    end

    def tokenize
      captures = text.match(/#{trigger_word}(?<text0>.+),? and at this point/i)
      self.captures[:text0] = captures[:text0]
      true
    end
  end
end
