module Jarvis
  class Exception < StandardError
  end
  class UnfitEnvironmentException < Exception
  end
  class ThirdPartyAPIFailure < Exception
  end
end
