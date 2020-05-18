module Tdc
  #
  # Knows how to transform the result of calling the TestDefinitionReader#read method from an Array
  # of Hash instances into an Array of ActiveSupport::HashWithIndifferentAccess instances.
  #
  module WithIndifferentAccessDecorator
    def read(*path_elements)
      definitions = super

      raise "Use 'with_indifferent_access' only for an Array" unless definitions.is_a?(Array)

      definitions.map do |definition|
        definition.is_a?(Hash) ? ActiveSupport::HashWithIndifferentAccess.new(definition) : definition
      end
    end
  end
end
