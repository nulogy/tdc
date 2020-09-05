module Tdc
  #
  # Knows how to read data definitions from YAML files.
  #
  class DataDefinitionFileReader < Tdc::DataDefinition
    EMPTY_DEFINITIONS = []

    attr_reader :catalog_root_directory

    def initialize(catalog_root_directory)
      @catalog_root_directory = catalog_root_directory
    end

    def read(*path_elements)
      reader = Tdc::YamlReaders::YamlReaderFactory.new(@catalog_root_directory, path_elements).create

      reader.data_definitions
    end
  end
end
