# frozen_string_literal: true

module Tdc
  module Generators
    #
    # Abstract base class for all Test Data Catalog generators.
    #
    class GeneratorBase
      attr_reader :generation_context

      # ARM (2020-08-05): For backwards compatibility. Consider removing.
      delegate :current_catalog, :data_definition, to: :generation_context

      def initialize(generation_context)
        @generation_context = generation_context
      end

      def generate
        raise Tdc::MissingOverrideError, "Implement the 'generate' method"
      end

      def instance_definitions
        raise Tdc::MissingOverrideError, "Implement the 'instance_definitions' method"
      end
    end
  end
end
