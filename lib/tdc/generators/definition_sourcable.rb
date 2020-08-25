module Tdc
  module Generators
    #
    # Creates ghost methods for use in generators.
    #
    # All ghost methods are named 'key'_definition where 'key' is a key into the instance_definition hash.
    #
    # Example:
    #
    # If an instance definition had "line" and "replenishment_parameters" keys then the following
    # ghost methods could be used to refer to the value associated with those keys:
    #
    #  line_definition
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
        if definition?(method)
          definition_source.fetch(method.to_s.gsub(/_definition$/, ""))
        elsif optional_definition?(method)
          definition_source[method.to_s.gsub(/_definition_optional$/, "")]
        else
          super
        end
      end

      def respond_to_missing?(method, include_all = false) # rubocop:disable Style/OptionalBooleanParameter
        definition?(method) || definition_optional?(method) ? true : super
      end

      def transform_method_to_definition_source_key(method)
        method.to_s.gsub(/_definition$/, "")
      end

      def definition?(method)
        method.to_s.end_with?("_definition")
      end

      def optional_definition?(method)
        method.to_s.end_with?("_definition_optional")
      end
    end
  end
end
