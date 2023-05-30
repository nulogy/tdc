module Tdc
  module YamlReaders
    #
    # YAML source.
    #
    class YamlReaderBase
      def initialize(catalog_root_directory, path_elements)
        @catalog_root_directory = catalog_root_directory
        @path_elements = path_elements
      end

      def applies?
        File.exist?(definitions_file)
      end

      def data_definitions
        definitions_source
      end

      def definitions_source
        source_string.empty? ? [] : YAML.safe_load(source_string, permitted_classes: [Date])
      rescue => e
        raise Tdc::FatalError, <<~MSG
          Unable to load YAML from #{definitions_file}
          Cause: #{e.message}"
        MSG
      end

      concerning :HookMethods do
        def file_extension
          raise MissingOverrideError, "Implement the 'file_extension' method"
        end

        def source_string
          raise MissingOverrideError, "Implement the 'source_string' method"
        end
      end

      private

      def definitions_file
        @_definitions_file ||= begin
          fully_qualified_path_elements = [@catalog_root_directory].concat(@path_elements.map(&:to_s))

          fully_qualified_path_elements.last.concat(file_extension)

          File.join(*fully_qualified_path_elements)
        end
      end
    end
  end
end
