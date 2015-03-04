module ImgFlipMemes
  class Picard < BaseMeme
    def template_id
      245898
    end

    def tokenize
      captures = text.match(/picard(?<text0>.[^,]+),?(?<text1>.[^,]+)?/i)
      self.captures[:text0], self.captures[:text1] = captures[:text0], captures[:text1]
      true
    end
  end
end
