RSpec.describe Tdc::Generators::SingularGenerator, :tdc do
  let(:current_catalog) { instance_double(Tdc::Generators::CatalogEntries) }
  let(:data_definition) { instance_double(Tdc::DataDefinition) }
  let(:generation_context) {
    Tdc::Generators::GenerationContext
      .new(current_catalog: current_catalog, data_definition: data_definition)
  }

  subject(:generator) { Support::TdcFixture::SampleSingularGenerator.new(generation_context) }

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

  # TDC (2020-05-21): Consider using a Shared Example.
  describe "definition sourcable" do
    it "invoke _definition methods" do
      instance_definitions = [
        instance_definition(tag: "manning", name: "Manning", wait: 2.0)
      ]

      generator.inject_instance_definitions(instance_definitions)

      generator.define_singleton_method :generate_instance do
        add_result([name_definition, wait_definition])
      end

      generator.generate

      expect(generator.results).to eq([["Manning", 2.0]])
    end

    it "tags are removed" do
      instance_definitions = [
        instance_definition(tag: "manning", name: "Manning", wait: 2.0)
      ]

      generator.inject_instance_definitions(instance_definitions)

      generator.define_singleton_method :generate_instance do
        add_result([tag_definition])
      end

      expect { generator.generate }.to raise_error(NameError)
    end
  end
end
