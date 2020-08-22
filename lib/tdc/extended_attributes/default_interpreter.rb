module Tdc
  module ExtendedAttributes
    #
    # Know how on interpret extended attributes.
    #
    # Note: extended attribute keys are expected to be strings rather than symbols.
    #
    class DefaultInterpreter < Tdc::ExtendedAttributes::InterpreterBase
      def interpret(instance_definition)
        extended_attribute_definitions = keep_extended_attributes_from(instance_definition)

        extended_attribute_definitions.each do |extended_attribute_key, extended_attribute_value|
          # Remove the extended attribute.
          instance_definition.delete(extended_attribute_key)

          # Add the extended attribute back as a standard attribute.
          instance_definition[convert_to_standard_attribute(extended_attribute_key)] =
            extended_attribute_context.instance_eval(extended_attribute_value)
        end
      end

      concerning :HookMethods do
        def convert_to_standard_attribute(extended_attribute_key)
          extended_attribute_key.gsub(/_(at|date|on)x$/, "_\\1")
        end

        def extended_attribute_context
          Time.zone
        end

        def extended_attribute?(extended_attribute_key)
          /_(at|date|on)x$/ =~ extended_attribute_key
        end
      end

      private

      def keep_extended_attributes_from(instance_definition)
        instance_definition.select { |extended_attribute_key, _| extended_attribute?(extended_attribute_key) }
      end
    end
  end
end
