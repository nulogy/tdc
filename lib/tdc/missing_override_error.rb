module Tdc
  class MissingOverrideError < Tdc::FatalError
    def initialize
      super("Must be implemented")
    end
  end
end
