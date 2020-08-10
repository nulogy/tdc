module Tdc
  module DefinitionResolvers
    #
    # Knows how to resolve the tag value for the specified instance_definition key by replacing it
    # with an object sourced from the current catalog.
    #
    class TagResolver < Tdc::DefinitionResolvers::DefinitionResolver
      attr_reader :key, :source

      def initialize(key:, source:)
        super()

        @key = key
        @source = source
      end

      def resolve(instance_definition)
        return unless instance_definition.key?(key)

        # Lookup the source catalog entry in the current_catalog.
        catalog_entry = instance_eval("current_catalog.#{source}", __FILE__, __LINE__)

        # Before resolution the instance definition value is a tag.
        tag = instance_definition[key]

        # Use the tag to source an object from the current catalog.
        sourced_object = catalog_entry.send(tag)

        unless sourced_object
          message = "Could not find a tag reference for '#{key}' in the catalog entries provided."

          raise Tdc::FatalError, message
        end

        # Replace the tag value with the sourced object.
        instance_definition[key] = sourced_object
      end
    end
  end
end
