# frozen_string_literal: true

module Tdc
  module DefinitionResolvers
    #
    # Knows how to resolve the tag value for the specified instance_definition key by replacing it
    # with an object sourced from the current catalog.
    #
    class TagResolver < Tdc::DefinitionResolvers::DefinitionResolver
      attr_reader :key, :source

      def initialize(key:, source:)
        @key = key
        @source = source
      end

      def resolve(instance_definition)
        return unless instance_definition.key?(key)

        # Lookup the source catalog entry in the current_catalog.
        catalog_entry = instance_eval("current_catalog.#{source}", __FILE__, __LINE__)

        # Before resolution the instance definition value is a tag.
        tag = instance_definition[key]

        unresolvable_tag(tag, catalog_entry) unless tag

        # Use the tag to source an object from the current catalog.
        sourced_object = catalog_entry.send(tag)

        unresolvable_tag(tag, catalog_entry) unless sourced_object

        # Replace the tag value with the sourced object.
        instance_definition[key] = sourced_object
      end

      private

      def unresolvable_tag(tag, catalog_entry)
        source_tags = catalog_entry.entries.sort.map { |entry| "'#{entry}'" }.to_sentence

        raise Tdc::FatalError, <<~MESSAGE
          Could not resolve key '#{key}' from source '#{source}'.

          Attempted to resolve tag '#{tag}' from these tags: #{source_tags}
        MESSAGE
      end
    end
  end
end
