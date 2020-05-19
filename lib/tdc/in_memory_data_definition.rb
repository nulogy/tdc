module Tdc
  #
  # Knows how to read test data definitions from an in-memory representation.
  #
  class InMemoryDataDefinition
    def initialize(path_elements_data = {})
      @store = path_elements_data
    end

    def store(path_elements, data)
      @store[path_elements] = data
    end

    def read(*path_elements)
      @store.fetch(path_elements) do
        raise MissingPathElementsError, "The path did not have any data associated with it: #{path_elements.inspect}"
      end
    end

    def with_indifferent_access
      self.extend(Tdc::WithIndifferentAccessDecorator) # rubocop:disable Style/RedundantSelf
    end
  end
end