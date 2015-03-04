module ImgFlipMemes
  class SuccessKid < BaseMeme
    def template_id
      61544
    end

    def tokenize
      captures = text.match(/success kid(?<text0>.[^,]+),?(?<text1>.[^,]+)?/i)
      self.captures[:text0], self.captures[:text1] = captures[:text0], captures[:text1]
      true
    end
  end
end
