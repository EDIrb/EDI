module ImgFlipMemes
  class YUNo < BaseMeme
    def template_id
      61527
    end

    def text0
      "Y U NO"
    end

    def tokenize
      captures = text.match(/y u no(?<text1>.+)/i)
      self.captures[:text1] = captures[:text1]
      true
    end
  end
end
