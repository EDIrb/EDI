module ImgFlipMemes
  class Everywhere < BaseMeme

    def template_id
      347390
    end

    def tokenize
      captures = text.match /#{trigger_word},? (?<text0>.+),(?<text1>.+ everywhere)?/i
      self.captures[:text0], self.captures[:text1] = captures[:text0], captures[:text1]
      true
    end

  end
end
