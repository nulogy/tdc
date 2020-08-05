module Tdc
  module Generators
    #
    # Knows all the parameters that define the context for generation.
    #
    class GenerationContext
      attr_reader :current_catalog, :data_definition

      def initialize(current_catalog:, data_definition:)
        @current_catalog = current_catalog
        @data_definition = data_definition
      end
    end
  end
end
