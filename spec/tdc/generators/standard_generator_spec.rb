# frozen_string_literal: true

RSpec.describe Tdc::Generators::StandardGenerator, :tdc do
  let(:current_catalog) { instance_double(Tdc::Generators::CatalogEntries) }
  let(:data_definition) { instance_double(Tdc::DataDefinition) }
  let(:generation_context) {
    Tdc::Generators::GenerationContext
      .new(current_catalog: current_catalog, data_definition: data_definition)
  }

  subject(:generator) { Support::TdcFixture::SampleStandardGenerator.new(generation_context) }

  include_examples "includes DefinitionSourcable"

  it "generates" do
    instance_definitions = [
      instance_definition(tag: "costello", name: "Costello"),
      instance_definition(tag: "manning", name: "Manning")
    ]

    generator.inject_instance_definitions(instance_definitions)

    expect(generator).to receive(:generate_instance).twice

    generator.generate
  end
end
