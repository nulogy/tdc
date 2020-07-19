module Tdc
  module Generators
    #
    # Knows how to provide a configurable instance definition.
    #
    # Shared implementation between the StandardGenerator and the SingularGenerator abstract classes.
    #
    class ConfigurableGenerator < Tdc::Generators::GeneratorBase
      include Tdc::Generators::DefinitionSourcable

      attr_reader :instance_definition

      source_definition_from :instance_definition

      def run_resolvers_and_generate_instance
        run_atx_resolvers(instance_definition)
        run_tag_resolvers(instance_definition)

        generate_instance
      end

      #
      # Hook method: subclasses are expected to define how to generate a model instance.
      #
      def generate_instance
        raise Tdc::MissingOverrideError, "Implement the 'generate_instance' method"
      end

      #
      # Hook method: subclasses may include the DefinitionResolvable concern to override.
      #
      def run_tag_resolvers(_instance_definition)
        # Do nothing
      end

      private

      def configure_instance_definition(instance_definition)
        @instance_definition = instance_definition

        configure_definition_source(instance_definition)
      end

      def run_atx_resolvers(instance_definition)
        atx_definitions = instance_definition.select { |k, _v| /_atx$/ =~ k }

        atx_definitions.each do |k, v|
          # Remove the original _atx attribute.
          instance_definition.delete(k)

          # Add a standard _at attribute.
          instance_definition[k.delete_suffix("x")] = eval(v) # rubocop:disable Security/Eval
        end
      end
    end
  end
end