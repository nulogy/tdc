module Tdc
  module Generators
    #
    # Knows a class instance that supplies the instance_eval context for interpreting _atx attribute values.
    #
    class AtxContextFactory
      include Singleton

      attr_reader :context

      def initialize
        @context = Time.zone
      end
    end
  end
end
