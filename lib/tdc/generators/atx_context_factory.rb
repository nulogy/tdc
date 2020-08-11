module Tdc
  module Generators
    #
    # Knows a class instance that supplies the instance_eval context for interpreting _atx attribute values.
    #
    class AtxContextFactory
      include Singleton

      attr_reader :context

      def self.register(context:)
        AtxContextFactory.instance.instance_variable_set(:@context, context)
      end

      def initialize
        @context = Time.zone
      end
    end
  end
end
