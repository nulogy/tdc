module Tdc
  module Generators
    #
    # Abstract class for defining generators that define a single model instance.
    #
    # See also StandardGenerator.
    #
    class SingularGenerator < Tdc::Generators::GeneratorBase
      include Tdc::Generators::InstanceDefinitionConfigurable

      def initialize(data_definition, current_catalog)
        super

        @additional_definitions = {}
      end

      def with_definition(additional_definitions)
        @additional_definitions = additional_definitions.stringify_keys.reject { |_, v| v == :missing_definition }

        self
      end

      def generate
        configure_instance_definition(singular_instance_definition.merge(@additional_definitions))

        run_resolvers_and_generate_instance
      end

      private

      def singular_instance_definition
        all_instance_definitions = instance_definitions

        if all_instance_definitions.many?
          raise Tdc::FatalError, "A singular generator only generates a single model instance"
        end

        # Delete the tag so that the models do not need to filter it out.
        all_instance_definitions.first.except("tag")
      end
    end
  end
end
