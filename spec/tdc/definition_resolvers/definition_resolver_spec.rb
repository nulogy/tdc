# frozen_string_literal: true

RSpec.describe Tdc::DefinitionResolvers::DefinitionResolver do
  describe "#updating?" do
    it "is false when no generation context is configured" do
      resolver = described_class.new

      expect(resolver.updating?).to be false
    end

    it "is false when generation context is not updating" do
      generation_context = Tdc::Generators::GenerationContext.new(
        current_catalog: Tdc::Generators::CatalogEntries.new,
        data_definition: instance_double(Tdc::DataDefinition)
      )

      resolver = described_class.new
      resolver.configure_generation_context(generation_context)

      expect(resolver.updating?).to be false
    end

    it "is true when generation context is updating" do
      generation_context = Tdc::Generators::GenerationContext.new(
        current_catalog: Tdc::Generators::CatalogEntries.new,
        data_definition: instance_double(Tdc::DataDefinition)
      )

      resolver = described_class.new
      resolver.configure_generation_context(generation_context)

      generation_context.with_updating do
        expect(resolver.updating?).to be true
      end
    end
  end
end
