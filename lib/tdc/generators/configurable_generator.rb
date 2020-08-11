module Tdc
  module Generators
    #
    # Knows how to provide a configurable instance definition.
    #
    class ConfigurableGenerator < Tdc::Generators::GeneratorBase
      include Tdc::Generators::DefinitionSourcable

      attr_reader :instance_definition

      source_definition_from :instance_definition

      def run_resolvers_and_generate_instance
        run_extended_attribute_interpreters(instance_definition)
        run_definition_resolvers(instance_definition)

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
      def run_definition_resolvers(_instance_definition)
        # Do nothing
      end

      private

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
