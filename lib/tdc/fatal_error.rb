module Tdc
  class FatalError < RuntimeError
    def initialize(msg = nil)
      super
    end
  end
end
