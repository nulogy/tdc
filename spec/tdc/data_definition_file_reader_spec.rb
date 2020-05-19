RSpec.describe Tdc::DataDefinitionFileReader do
  it "raises when test definition file is missing" do
    reader = create_reader("catalog_root")

    expect(YAML).to_not receive(:load)

    expect { reader.read("top_level") }.to raise_error(
      Tdc::FatalError, "Missing test definitions file: 'catalog_root/top_level.yml'"
    )
  end

  def create_reader(catalog_root_directory)
    described_class.new(catalog_root_directory)
  end
end
