RSpec.describe Tdc::Generators::CatalogEntries do
  subject(:catalog_entries) { described_class.new }

  describe "empty?" do
    it "initially empty" do
      expect(catalog_entries).to be_empty
    end

    it "not empty after adding a catalog entry" do
      catalog_entries.add_catalog_entry(:pallet_capacity, 20)

      expect(catalog_entries).to_not be_empty
    end
  end
end
