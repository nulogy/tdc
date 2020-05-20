RSpec.describe Tdc::Generators::SingularGenerator do
  let(:current_catalog) { instance_double(Tdc::Generators::CatalogEntries) }
  let(:data_definition) { instance_double(Tdc::DataDefinition) }

  subject(:generator) { Support::TdcFixture::SampleSingularGenerator.new(data_definition, current_catalog) }

  it "generates" do
    singular_instance_definitions = [
      instance_definition(tag: "manning", name: "Manning")
    ]

    generator.inject_instance_definitions(singular_instance_definitions)

    expect(generator).to receive(:generate_instance)

    generator.generate
  end

  it "fails to generate for multiple instances" do
    non_singular_instance_definitions = [
      instance_definition(tag: "manning", name: "Manning"),
      instance_definition(tag: "costello", name: "Costello")
    ]

    generator.inject_instance_definitions(non_singular_instance_definitions)

    expect(generator).to_not receive(:generate_instance)

    expect { generator.generate }.to raise_error(
      Tdc::FatalError, "A singular generator only generates a single model instance"
    )
  end

  describe "definition sourcable" do
    it "invoke _definition methods" do
      singular_instance_definitions = [
        instance_definition(tag: "manning", name: "Manning", wait: 2.0)
      ]

      generator.inject_instance_definitions(singular_instance_definitions)

      generator.define_singleton_method :generate_instance do
        [name_definition, wait_definition]
      end

      expect(generator.generate).to eq(["Manning", 2.0])
    end

    it "tags are removed" do
      singular_instance_definitions = [
        instance_definition(tag: "manning", name: "Manning", wait: 2.0)
      ]

      generator.inject_instance_definitions(singular_instance_definitions)

      generator.define_singleton_method :generate_instance do
        [tag_definition]
      end

      expect { generator.generate }.to raise_error(NameError)
    end
  end

  def instance_definition(definition)
    ActiveSupport::HashWithIndifferentAccess.new(definition)
  end
end
