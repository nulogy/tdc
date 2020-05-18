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
        key = transform_method_to_definition_source_key(method)

        definition_source.key?(key) ? definition_source.fetch(key) : super
      end

      def respond_to_missing?(method, include_all = false)
        key = transform_method_to_definition_source_key(method)

        definition_source.key?(key) ? true : super
      end

      def transform_method_to_definition_source_key(method)
        method.to_s.gsub(/_definition$/, "")
      end
    end
  end
end
