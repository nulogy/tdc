# frozen_string_literal: true

module Tdc
  module ExtendedAttributes
    class InterpreterBase
      def interpret(_instance_definition)
        raise Tdc::MissingOverrideError, "Implement the 'keep_extended_attributes' method"
      end
    end
  end
end
