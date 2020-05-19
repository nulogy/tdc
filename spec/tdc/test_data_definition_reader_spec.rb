RSpec.describe Tdc::TestDataDefinitionReader do
  it "reads single definition" do
    reader = create_reader("catalog_root")

    expect(YAML).to receive(:load).with(nil)

    reader.read("top_level")
  end

  def create_reader(catalog_root_directory)
    described_class.new(catalog_root_directory)
  end
end
