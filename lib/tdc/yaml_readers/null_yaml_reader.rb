# frozen_string_literal: true

module Tdc
  module YamlReaders
    #
    # When we can't find a YAML source.
    #
    class NullYamlReader
      def data_definitions
        []
      end
    end
  end
end
