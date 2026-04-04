# frozen_string_literal: true

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
        @updating = false
      end

      def updating?
        @updating
      end

      def with_updating
        @updating = true
        yield
      ensure
        @updating = false
      end
    end
  end
end
