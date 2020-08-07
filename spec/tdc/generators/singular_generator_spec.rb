RSpec.describe Tdc::Generators::SingularGenerator, :tdc do
  let(:current_catalog) { instance_double(Tdc::Generators::CatalogEntries) }
  let(:data_definition) { instance_double(Tdc::DataDefinition) }
  let(:generation_context) {
    Tdc::Generators::GenerationContext
      .new(current_catalog: current_catalog, data_definition: data_definition)
  }

  subject(:generator) { Support::TdcFixture::SampleSingularGenerator.new(generation_context) }

  include_examples "includes DefinitionSourcable"
  include_examples "inherits from ConfigurableGenerator"

  it "generates" do
    instance_definitions = [
      instance_definition(tag: "manning", name: "Manning")
    ]

    generator.inject_instance_definitions(instance_definitions)

    expect(generator).to receive(:generate_instance)

    generator.generate
  end

  it "fails to generate for multiple instances" do
    instance_definitions = [
      instance_definition(tag: "manning", name: "Manning"),
      instance_definition(tag: "costello", name: "Costello")
    ]

    generator.inject_instance_definitions(instance_definitions)

    expect(generator).to_not receive(:generate_instance)

    expect { generator.generate }.to raise_error(
      Tdc::FatalError, "A singular generator only generates a single model instance"
    )
  end
end
