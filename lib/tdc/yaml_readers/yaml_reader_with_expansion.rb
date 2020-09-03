module Tdc
  module YamlReaders
    #
    # YAML source is a YAML file that undergoes ERB expansion.
    #
    class YamlReaderWithExpansion < Tdc::YamlReaders::YamlReaderBase
      def file_extension
        ".yml.erb"
      end

      def source_string
        ERB.new(File.read(definitions_file)).result
      end
    end
  end
end
