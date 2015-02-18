require 'active_support/core_ext'

class Symbol
  def constantize
    self.to_s.camelize.constantize
  end
end
