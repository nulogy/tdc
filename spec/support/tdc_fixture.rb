module Support
  #
  # A globally shared test fixture. See the tdc_spec_helper.
  #
  module TdcFixture
    module SampleHelpers
      extend ActiveSupport::Concern

      included do
        attr_reader :instance_definitions
        attr_reader :results
      end

      def inject_instance_definitions(instance_definitions)
        @instance_definitions = instance_definitions

        self
      end

      def add_result(result)
        @results ||= []

        @results << result
      end
    end

    class SampleSingularGenerator < Tdc::Generators::SingularGenerator
      include SampleHelpers

      private

      def generate_instance
      end
    end

    class SampleStandardGenerator < Tdc::Generators::StandardGenerator
      include SampleHelpers

      private

      def generate_instance
      end
    end
  end
end
