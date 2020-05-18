module Tdc
  module Generators
    #
    # Knows how to resolve tag values in an instance definition. The tag value will be replaced
    # with a model instance from the current catalog.
    #
    # The resolve_tag class macro is provided for generators to define tag resolution.
    #
    # Example:
    #
    # Suppose a particular instance definition contained { subcomponent: sc_snackers_minis }
    # then a generator could resolve the subcomponent by defining:
    #
    #   resolve_tag key: :subcomponent, source: "item_master.items"
    #
    module DefinitionResolvable
      extend ActiveSupport::Concern

      included do
        class_attribute :_tag_resolvers, instance_writer: false
        self._tag_resolvers = []
      end

      class_methods do
        def resolve_tag(key:, source:)
          _tag_resolvers << [key, source]
        end
      end

      def run_tag_resolvers(instance_definition)
        _tag_resolvers.each { |key, source| _resolve_tag_reference(instance_definition, key, source) }
      end

      private

      #
      # Replace the tag value for the specified instance_definition key with an object sourced from the current catalog.
      #
      def _resolve_tag_reference(instance_definition, key, source)
        return unless instance_definition.key?(key)

        # Lookup the source catalog entry in the current_catalog.
        catalog_entry = instance_eval("current_catalog.#{source}", __FILE__, __LINE__)

        # Before resolution the instance definition value is a tag.
        tag = instance_definition[key]

        # Use the tag to source an object from the current catalog.
        sourced_object = catalog_entry.send(tag)

        raise "Could not find a tag reference for '#{key}' in the catalog entries provided." unless sourced_object

        # Replace the tag value with the sourced object.
        instance_definition[key] = sourced_object
      end
    end
  end
end
