module ImgFlipMemes
  class SuddenClarity < BaseMeme
    def template_id
      100948
    end

    def tokenize
      captures = text.match(/sudden clarity(?<text0>.[^,]+),?(?<text1>.[^,]+)?/i)
      self.captures[:text0], self.captures[:text1] = captures[:text0], captures[:text1]
      true
    end
  end
end
