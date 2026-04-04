# frozen_string_literal: true

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

    #
    # A simple record-like object for testing update-or-create behavior.
    #
    class FakeRecord
      attr_reader :attributes

      def initialize(attributes = {})
        @attributes = attributes
      end

      def update!(new_attributes)
        @attributes = @attributes.merge(new_attributes)
        true
      end

      def [](key)
        @attributes[key]
      end
    end

    #
    # A generator that creates FakeRecord instances for testing update-or-create.
    #
    class FakeRecordGenerator < Tdc::Generators::StandardGenerator
      attr_reader :instance_definitions

      def inject_instance_definitions(instance_definitions)
        @instance_definitions = instance_definitions

        self
      end

      def generate_instance
        FakeRecord.new(instance_definition)
      end
    end
  end
end
