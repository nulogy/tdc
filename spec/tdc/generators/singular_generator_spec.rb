RSpec.describe Tdc::Generators::SingularGenerator do
  subject(:singular_generator) { Support::TdcFixture::SampleSingularGenerator }

  it "generates" do
    current_catalog = double
    data_definition = double

    generator = singular_generator.new(data_definition, current_catalog)

    generator.generate
  end
end
