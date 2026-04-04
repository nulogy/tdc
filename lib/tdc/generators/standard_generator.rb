# frozen_string_literal: true

module Tdc
  module Generators
    #
    # Knows how to provide a configurable instance definition.
    #
    class StandardGenerator < Tdc::Generators::GeneratorBase
      include Tdc::Generators::DefinitionSourcable

      attr_reader :instance_definition

      source_definition_from :instance_definition

      def generate
        CatalogEntries.new.tap do |catalog_entries|
          instance_definitions.each do |instance_definition|
            configure_instance_definition(instance_definition)

            # Delete the tag so that the models do not need to filter it out.
            tag = instance_definition.delete("tag")

            existing_record = find_existing_record(tag, catalog_entries)

            if existing_record
              generated = run_resolvers_and_update_instance(existing_record)
            else
              generated = run_resolvers_and_generate_instance
            end

            # Add generated instance to the catalog entries whenever a tag provided.
            catalog_entries.add_catalog_entry(tag, generated) if tag
          end
        end
      end

      def run_resolvers_and_generate_instance
        run_extended_attribute_interpreters(instance_definition)
        run_definition_resolvers(instance_definition)

        generate_instance
      end

      def run_resolvers_and_update_instance(existing_record)
        generation_context.with_updating do
          run_extended_attribute_interpreters(instance_definition)
          run_definition_resolvers(instance_definition)

          update_instance(existing_record)
        end
      end

      #
      # Hook method: subclasses are expected to define how to generate a model instance.
      #
      def generate_instance
        raise Tdc::MissingOverrideError, "Implement the 'generate_instance' method"
      end

      #
      # Hook method: subclasses may override to customize update behavior for existing records.
      #
      def update_instance(existing_record)
        existing_record.update!(instance_definition)
        existing_record
      end

      #
      # Hook method: subclasses may include the DefinitionResolvable concern to override.
      #
      def run_definition_resolvers(_instance_definition)
        # Do nothing
      end

      private

      def find_existing_record(tag, catalog_entries)
        return unless tag

        catalog_entries.to_h.key?(tag.to_sym) ? catalog_entries.send(tag) : nil
      end

      def configure_instance_definition(instance_definition)
        @instance_definition = instance_definition

        configure_definition_source(instance_definition)
      end

      def run_extended_attribute_interpreters(instance_definition)
        interpreters.each { |interpreter| interpreter.interpret(instance_definition) }
      end

      def interpreters
        Tdc::ExtendedAttributes::InterpreterRegistry.instance.interpreters
      end
    end
  end
end
