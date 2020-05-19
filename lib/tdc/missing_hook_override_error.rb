module Tdc
  class MissingHookOverrideError < RuntimeError
    def initialize
      super("Must be implemented")
    end
  end
end
