# frozen_string_literal: true

module Tdc
  module YamlReaders
    #
    # Knows how to create the appropriate YAML reader.
    #
    class YamlReaderFactory
      def initialize(catalog_root_directory, path_elements)
        @catalog_root_directory = catalog_root_directory
        @path_elements = path_elements
      end

      def create
        if yaml_reader_with_expansion.applies?
          yaml_reader_with_expansion
        elsif yaml_reader.applies?
          yaml_reader
        else
          null_reader
        end
      end

      private

      def yaml_reader_with_expansion
        @_yaml_reader_with_expansion ||=
          Tdc::YamlReaders::YamlReaderWithExpansion.new(@catalog_root_directory, @path_elements)
      end

      def null_reader
        @_null_reader ||= Tdc::YamlReaders::NullYamlReader.new
      end

      def yaml_reader
        @_yaml_reader ||= Tdc::YamlReaders::YamlReader.new(@catalog_root_directory, @path_elements)
      end
    end
  end
end
