module Tdc
  module Generators
    #
    # Abstract base class for all Test Data Catalog generators.
    #
    class GeneratorBase
      attr_reader :data_definition, :current_catalog

      def initialize(data_definition, current_catalog)
        @data_definition = data_definition
        @current_catalog = current_catalog
      end

      def generate
        raise Tdc::MissingHookOverrideError
      end

      def instance_definitions
        raise Tdc::MissingHookOverrideError
      end
    end
  end
end
