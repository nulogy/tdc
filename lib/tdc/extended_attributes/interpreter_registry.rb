# frozen_string_literal: true

module Tdc
  module ExtendedAttributes
    #
    # Knows the class instances that interpret extended attribute values.
    #
    class InterpreterRegistry
      include Singleton

      def self.register(interpreter:)
        instance.register_interpreter(interpreter)
      end

      def initialize
        @interpreters = []
      end

      def clear
        @interpreters = []
      end

      def interpreters
        @interpreters.empty? ? [default_interpreter] : @interpreters
      end

      def register_interpreter(interpreter)
        raise Tdc::FatalError, <<~MSG.chomp unless interpreter.is_a?(Tdc::ExtendedAttributes::InterpreterBase)
          Cannot register an interpreter unless it inherits from Tdc::ExtendedAttributes::InterpreterBase
        MSG

        # Avoid registering the same class of interpreter a second time.
        return if @interpreters.map(&:class).include?(interpreter.class)

        @interpreters << interpreter
      end

      private

      def default_interpreter
        @_default_interpreter ||= Tdc::ExtendedAttributes::DefaultInterpreter.new
      end
    end
  end
end
