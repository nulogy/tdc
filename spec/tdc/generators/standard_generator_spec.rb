# frozen_string_literal: true

RSpec.describe Tdc::Generators::StandardGenerator, :tdc do
  let(:current_catalog) { instance_double(Tdc::Generators::CatalogEntries) }
  let(:data_definition) { instance_double(Tdc::DataDefinition) }
  let(:generation_context) {
    Tdc::Generators::GenerationContext
      .new(current_catalog: current_catalog, data_definition: data_definition)
  }

  subject(:generator) { Support::TdcFixture::SampleStandardGenerator.new(generation_context) }

  it_behaves_like "includes DefinitionSourcable"

  it "generates" do
    instance_definitions = [
      instance_definition(tag: "costello", name: "Costello"),
      instance_definition(tag: "manning", name: "Manning")
    ]

    generator.inject_instance_definitions(instance_definitions)

    expect(generator).to receive(:generate_instance).twice

    generator.generate
  end

  describe "update-or-create" do
    subject(:generator) { Support::TdcFixture::FakeRecordGenerator.new(generation_context) }

    it "creates a record when the tag is new" do
      instance_definitions = [
        instance_definition(tag: "costello", name: "Costello"),
      ]

      generator.inject_instance_definitions(instance_definitions)

      result = generator.generate

      expect(result.costello.attributes).to include("name" => "Costello")
    end

    it "updates an existing record when the tag matches a previously created record" do
      instance_definitions = [
        instance_definition(tag: "costello", name: "Costello", score: 10),
        instance_definition(tag: "costello", score: 99),
      ]

      generator.inject_instance_definitions(instance_definitions)

      result = generator.generate

      expect(result.costello.attributes).to include("name" => "Costello", "score" => 99)
    end

    it "creates new records alongside updates to existing records" do
      instance_definitions = [
        instance_definition(tag: "costello", name: "Costello", score: 10),
        instance_definition(tag: "costello", score: 99),
        instance_definition(tag: "manning", name: "Manning", score: 50),
      ]

      generator.inject_instance_definitions(instance_definitions)

      result = generator.generate

      expect(result.costello.attributes).to include("name" => "Costello", "score" => 99)
      expect(result.manning.attributes).to include("name" => "Manning", "score" => 50)
    end

    it "does not confuse a tag with an inherited method name" do
      instance_definitions = [
        instance_definition(tag: "display", name: "Displays"),
      ]

      generator.inject_instance_definitions(instance_definitions)

      expect { generator.generate }.not_to output.to_stdout
    end

    it "sets updating? on generation_context during update" do
      updating_during_call = nil

      allow(generator).to receive(:update_instance).and_wrap_original do |method, existing_record|
        updating_during_call = generation_context.updating?
        method.call(existing_record)
      end

      instance_definitions = [
        instance_definition(tag: "costello", name: "Costello"),
        instance_definition(tag: "costello", score: 99),
      ]

      generator.inject_instance_definitions(instance_definitions)
      generator.generate

      expect(updating_during_call).to be true
      expect(generation_context.updating?).to be false
    end
  end
end
