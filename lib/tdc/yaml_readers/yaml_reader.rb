# frozen_string_literal: true

module Tdc
  module YamlReaders
    #
    # YAML source is a YAML file.
    #
    class YamlReader < Tdc::YamlReaders::YamlReaderBase
      def file_extension
        ".yml"
      end

      def source_string
        File.read(definitions_file)
      end
    end
  end
end
