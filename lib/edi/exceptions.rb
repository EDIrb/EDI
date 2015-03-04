module EDI
  class Exception < StandardError
  end
  class UnfitEnvironmentException < Exception
  end
  class ThirdPartyAPIFailure < Exception
  end
end
