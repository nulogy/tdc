module Tdc
  module ExtendedAttributes
    class DefaultInterpreter < Tdc::ExtendedAttributes::InterpreterBase
      def interpret(instance_definition)
        extended_attribute_definitions = keep_extended_attributes(instance_definition)

        extended_attribute_definitions.each do |k, v|
          # Remove the original extended attribute.
          instance_definition.delete(k)

          # Add a standard attribute.
          instance_definition[convert_to_standard_attribute(k)] = extended_attribute_context.instance_eval(v)
        end
      end

      concerning :HookMethods do
        def convert_to_standard_attribute(k) # rubocop:disable Naming/MethodParameterName
          k.delete_suffix("x")
        end

        def extended_attribute_context
          Time.zone
        end

        def keep_extended_attributes(instance_definition)
          instance_definition.select { |k, _v| /_(at|date|on)x$/ =~ k }
        end
      end
    end
  end
end
