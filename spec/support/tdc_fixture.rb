module Support
  #
  # A globally shared test fixture
  #
  module TdcFixture
    class SampleSingularGenerator < Tdc::Generators::SingularGenerator
      def generate
        # TDC (2020-05-20): TBD
      end
    end

    class SampleStandardGenerator < Tdc::Generators::StandardGenerator
      def generate
        # TDC (2020-05-20): TBD
      end
    end
  end
end
