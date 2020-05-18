module TestDataCatalog
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
      # TDC (2020-05-18): Should we define our own RuntimeError rather than raise?
      @store.fetch(path_elements) do
        raise "The path did not have any data associated with it: #{path_elements.inspect}"
      end
    end

    def with_indifferent_access
      self.extend(TestDataCatalog::WithIndifferentAccessDecorator) # rubocop:disable Style/RedundantSelf
    end
  end
end
