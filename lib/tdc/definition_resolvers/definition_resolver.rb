module Tdc
  module DefinitionResolvers
    #
    # Base class for any definition resolver.
    #
    class DefinitionResolver
      attr_reader :current_catalog

      def configure_current_catalog(current_catalog)
        @current_catalog = current_catalog

        self
      end

      def resolve(_instance_definition)
        raise Tdc::MissingOverrideError, "Implement the 'resolve' method"
      end
    end
  end
end
