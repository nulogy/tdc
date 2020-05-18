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
        raise "Must be implemented"
      end

      def instance_definitions
        raise "Must be implemented"
      end
    end
  end
end
