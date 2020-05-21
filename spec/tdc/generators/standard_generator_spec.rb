RSpec.describe Tdc::Generators::StandardGenerator do
  subject(:standard_generator) { Support::TdcFixture::SampleStandardGenerator }

  xit "generates" do
    current_catalog = instance_double(Tdc::Generators::CatalogEntries)
    data_definition = instance_double(Tdc::DataDefinition)

    generator = standard_generator.new(data_definition, current_catalog)

    generator.generate
  end
end
