module Tdc
  module Generators
    #
    # Abstract class for defining generators that define a collection of model instances.
    #
    # See also SingularGenerator.
    #
    class StandardGenerator < Tdc::Generators::GeneratorBase
      include Tdc::Generators::InstanceDefinitionConfigurable

      def generate
        CatalogEntries.new.tap do |catalog_entries|
          instance_definitions.each do |instance_definition|
            configure_instance_definition(instance_definition)

            # Delete the tag so that the models do not need to filter it out.
            tag = instance_definition.delete("tag")

            generated = run_resolvers_and_generate_instance

            # Add generated instance to the catalog entries whenever a tag provided.
            catalog_entries.add_catalog_entry(tag, generated) if tag
          end
        end
      end
    end
  end
end
