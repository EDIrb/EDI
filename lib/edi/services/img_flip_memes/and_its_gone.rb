module ImgFlipMemes
  class AndItsGone < BaseMeme
    def template_id
      766986
    end

    def text1
      "Annnnnnnd it's gone"
    end

    def tokenize
      captures = text.match(/#{trigger_word},? (?<text0>.+)and it'?s gone/i)
      self.captures[:text0] = captures[:text0]
      true
    end
  end
end
