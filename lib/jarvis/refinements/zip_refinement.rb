module ZipRefinement
  refine String do
    def contains_zip?
      self.match(/\d{5}/) ? true : false
    end

    def zip_code
      self.match(/(?<zip>\d{5})/)[:zip]
    end
  end
end
