# frozen_string_literal: true

module Tdc
  module DefinitionResolvers
    #
    # Base class for any definition resolver.
    #
    class DefinitionResolver
      attr_reader :current_catalog, :generation_context

      def configure_current_catalog(current_catalog)
        @current_catalog = current_catalog

        self
      end

      def configure_generation_context(generation_context)
        @generation_context = generation_context

        self
      end

      def updating?
        generation_context&.updating? == true
      end

      def resolve(_instance_definition)
        raise Tdc::MissingOverrideError, "Implement the 'resolve' method"
      end
    end
  end
end
