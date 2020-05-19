module Tdc
  #
  # Knows how to read data definitions from YAML files.
  #
  class TestDataDefinitionReader < Tdc::DataDefinition
    EMPTY_DEFINITIONS = []

    def initialize(catalog_root_directory)
      @catalog_root_directory = catalog_root_directory
    end

    def read(*path_elements)
      data_definition_from(definitions_file(path_elements))
    end

    private

    def definitions_file(path_elements)
      fully_qualified_path_elements = [@catalog_root_directory].concat(path_elements.map(&:to_s))

      fully_qualified_path_elements.last.concat(".yml")

      File.join(*fully_qualified_path_elements)
    end

    def data_definition_from(definitions_file)
      if File.exist?(definitions_file)
        load_yaml(definitions_file) || EMPTY_DEFINITIONS
      else
        missing_data_definition(definitions_file)
      end
    end

    def load_yaml(definitions_file)
      YAML.load(expand_erb(definitions_file)) # rubocop:disable Security/YAMLLoad
    rescue => e
      raise Tdc::FatalError, <<~MSG
        Unable to load YAML from #{definitions_file}
        Cause: #{e.message}"
      MSG
    end

    def expand_erb(definitions_file)
      ERB.new(File.read(definitions_file)).result
    end

    def missing_data_definition(definitions_file)
      return EMPTY_DEFINITIONS if ENV.key?("TDC_IGNORE_MISSING_TEST_DATA_DEFINITION_ERROR")

      raise Tdc::FatalError, "Missing test definitions file: '#{definitions_file}'"
    end
  end
end
