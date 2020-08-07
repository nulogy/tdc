module Support
  #
  # A globally shared test fixture. See the tdc_spec_helper.
  #
  module TdcFixture
    class SampleStandardGenerator < Tdc::Generators::StandardGenerator
      attr_reader :instance_definitions, :results

      def inject_instance_definitions(instance_definitions)
        @instance_definitions = instance_definitions

        self
      end

      def add_result(result)
        @results ||= []

        @results << result
      end

      def generate_instance
      end
    end
  end
end
