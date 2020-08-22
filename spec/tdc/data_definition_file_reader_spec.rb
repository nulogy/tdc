RSpec.describe Tdc::DataDefinitionFileReader do
  it "does not raise when test definition file is missing" do
    reader = create_reader("catalog_root")

    data_definition = reader.read("missing")

    expect(data_definition).to eq([])
  end

  it "runs the YAML through ERB" do
    fully_qualified_path = File.join("catalog_root", "definition.yml")

    allow(File).to receive(:exist?).with(fully_qualified_path).and_return(true)
    allow(File).to receive(:read).with(fully_qualified_path).and_return(<<~YAML)
      - tag: tag
        note: <%= "expanded" %>
    YAML

    reader = create_reader("catalog_root")

    data_definition = reader.read("definition").first

    expect(data_definition).to include("tag" => "tag", "note" => "expanded")
  end

  def create_reader(catalog_root_directory)
    described_class.new(catalog_root_directory)
  end
end
