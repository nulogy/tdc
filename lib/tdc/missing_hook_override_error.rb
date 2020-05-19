module Tdc
  class MissingHookOverrideError < Tdc::FatalError
    def initialize
      super("Must be implemented")
    end
  end
end
