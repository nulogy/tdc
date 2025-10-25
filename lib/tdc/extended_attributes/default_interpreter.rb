# frozen_string_literal: true

module Tdc
  module ExtendedAttributes
    #
    # Know how on interpret extended attributes.
    #
    # Note: extended attribute keys are expected to be strings rather than symbols.
    #
    class DefaultInterpreter < Tdc::ExtendedAttributes::InterpreterBase
      def interpret(instance_definition)
        extended_attribute_definitions = keep_extended_attributes(instance_definition)

        extended_attribute_definitions.each do |extended_attribute_key, extended_attribute_value|
          # Remove the extended attribute.
          instance_definition.delete(extended_attribute_key)

          # Add the extended attribute back as a standard attribute.
          instance_definition[convert_to_standard_attribute(extended_attribute_key)] =
            extended_attribute_context.instance_eval(extended_attribute_value)
        end
      end

      concerning :HookMethods do
        def extended_attribute_context
          Time.zone
        end
      end

      private

      EXTENDED_ATTRIBUTE_SUFFIX = "_xa"

      def convert_to_standard_attribute(extended_attribute_key)
        extended_attribute_key.delete_suffix(EXTENDED_ATTRIBUTE_SUFFIX)
      end

      def extended_attribute?(extended_attribute_key)
        extended_attribute_key.end_with?(EXTENDED_ATTRIBUTE_SUFFIX)
      end

      def keep_extended_attributes(instance_definition)
        instance_definition.select do |extended_attribute_key, _|
          extended_attribute?(extended_attribute_key)
        end
      end
    end
  end
end
