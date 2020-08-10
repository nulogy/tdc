module Tdc
  #
  # Knows how to read data definitions from an in-memory representation.
  #
  class InMemoryDataDefinition < Tdc::DataDefinition
    def initialize(path_elements_data = {})
      super()

      @store = path_elements_data
    end

    def read(*path_elements)
      @store.fetch(path_elements) do
        raise Tdc::FatalError, "The path did not have any data associated with it: #{path_elements.inspect}"
      end
    end

    def store(path_elements, data)
      @store[path_elements] = data
    end
  end
end
