module ImgFlipMemes
  class OneDoesNotSimply < BaseMeme
    def template_id
      61579
    end

    def text0
      "One Does Not Simply"
    end

    def tokenize
      captures = text.match(/one does not simply(?<text1>.+)/i)
      self.captures[:text1] = captures[:text1]
      true
    end
  end
end
