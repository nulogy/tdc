module Tdc
  module Generators
    #
    # Creates ghost methods for use in generators.
    #
    # All ghost methods are named 'key'_definition or 'key'_definition_optional where 'key' is
    # a key into the instance_definition hash.
    #
    # Choose optional if the key may not be present in the instance_definition.
    #
    # Example:
    #
    # If an instance definition had "line" and "replenishment_parameters" keys then the following
    # ghost methods could be used to refer to the value associated with those keys:
    #
    #  line_definition
    #  line_definition_optional
    #  replenishment_parameters_definition
    #
    module DefinitionSourcable
      extend ActiveSupport::Concern

      class_methods do
        def source_definition_from(definition)
          class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
            def definition_source
              @definition_source ||= #{definition}
            end
          RUBY
        end
      end

      def configure_definition_source(definition)
        @definition_source = definition
      end

      private

      def method_missing(method, *args)
        if ghost_definition?(method)
          definition_source.fetch(method.to_s.gsub(/_definition$/, ""))
        elsif ghost_optional_definition?(method)
          definition_source[method.to_s.gsub(/_definition_optional$/, "")]
        else
          super
        end
      end

      def respond_to_missing?(method, include_all = false) # rubocop:disable Style/OptionalBooleanParameter
        ghost_definition?(method) || ghost_optional_definition?(method) ? true : super
      end

      def ghost_definition?(method)
        method.to_s.end_with?("_definition")
      end

      def ghost_optional_definition?(method)
        method.to_s.end_with?("_definition_optional")
      end
    end
  end
end
