module Tdc
  #
  # Knows how to read data definitions from the specified path elements.
  #
  class DataDefinition
    def read(*_path_elements)
      raise MissingOverrideError
    end

    def with_indifferent_access
      self.extend(Tdc::WithIndifferentAccessDecorator) # rubocop:disable Style/RedundantSelf
    end
  end
end
