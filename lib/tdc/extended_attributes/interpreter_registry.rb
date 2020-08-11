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

      def interpreters
        @interpreters << Tdc::ExtendedAttributes::DefaultInterpreter.new if @interpreters.empty?

        @interpreters
      end

      def register_interpreter(interpreter)
        raise Tdc::FatalError, <<~MSG unless interpreter.is_a?(Tdc::ExtendedAttributes::InterpreterBase)
          Cannot register an interpreter unless it inherits from Tdc::ExtendedAttributes::InterpreterBase
        MSG

        @interpreters << interpreter
      end
    end
  end
end
