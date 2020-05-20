RSpec.describe Tdc::Generators::StandardGenerator do
  subject(:standard_generator) { Support::TdcFixture::SampleStandardGenerator }

  it "generates" do
    current_catalog = double
    data_definition = double

    generator = standard_generator.new(data_definition, current_catalog)

    generator.generate
  end
end
