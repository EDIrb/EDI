module ImgFlipMemes
  class NotSureIf < BaseMeme
    def template_id
      61520
    end

    def tokenize
      captures = text.match(/#{trigger_word}.+(?<text0>not sure if.+),(?<text1>.+)/i)
      self.captures[:text0], self.captures[:text1] = captures[:text0], captures[:text1]
      true
    end
  end
end
