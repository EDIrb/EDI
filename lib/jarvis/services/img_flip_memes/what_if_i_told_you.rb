module ImgFlipMemes
  class WhatIfIToldYou < BaseMeme
    def template_id
      100947
    end

    def text0
      "What if I told you"
    end

    def tokenize
      captures = text.match(/what if i told you(?<text1>.+)/i)
      self.captures[:text1] = captures[:text1]
      true
    end
  end
end
