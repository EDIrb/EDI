module ImgFlipMemes
  class MostInterestingMan < BaseMeme
    def template_id
      61532
    end

    def tokenize
      captures = text.match(/#{trigger_word}.+(?<text0>i don'?t always.+), (?<text1>but when I do.+)/i)
      self.captures[:text0], self.captures[:text1] = captures[:text0], captures[:text1]
      true
    end
  end
end
