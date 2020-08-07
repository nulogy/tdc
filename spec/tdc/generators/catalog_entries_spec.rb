RSpec.describe Tdc::Generators::CatalogEntries do
  subject(:catalog_entries) { described_class.new }

  describe "#empty?" do
    it "initially empty" do
      expect(catalog_entries).to be_empty
    end

    it "not empty after adding a catalog entry" do
      catalog_entries.add_catalog_entry(:pallet_capacity, 20)

      expect(catalog_entries).to_not be_empty
    end
  end

  describe "#single_entry" do
    it "returns the one entry" do
      catalog_entries.collection = empty_collection

      catalog_entries.collection.entry_1 = :value_1

      expect(catalog_entries.collection.single_entry).to be(:value_1)
    end

    it "fails if there is more than one entry" do
      catalog_entries.collection = empty_collection

      catalog_entries.collection.entry_1 = :value_1
      catalog_entries.collection.entry_2 = :value_2

      expect { catalog_entries.collection.single_entry }.to raise_error(
        Tdc::FatalError, "There is more than one entry"
      )
    end
  end

  def empty_collection
    described_class.new
  end
end
