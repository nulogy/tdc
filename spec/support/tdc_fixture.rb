module Support
  #
  # A globally shared test fixture. See the tdc_spec_helper.
  #
  module TdcFixture
    class SampleSingularGenerator < Tdc::Generators::SingularGenerator
      attr_reader :instance_definitions

      def inject_instance_definitions(instance_definitions)
        @instance_definitions = instance_definitions
      end

      private

      def generate_instance
      end
    end

    class SampleStandardGenerator < Tdc::Generators::StandardGenerator
    end
  end
end
