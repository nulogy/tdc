RSpec.describe Tdc::DataDefinition do
  subject(:data_definition) {
    Class.new(described_class) do
      def initialize(result)
        @result = result
      end

      def read(*)
        @result
      end
    end
  }

  describe "with_indifferent_access" do
    it "wraps result with HashWithIndifferentAccess" do
      result = [{ "tag" => "costello", "code" => "Costello" }]

      decorated_data_definition = data_definition.new(result).with_indifferent_access

      transformed_result = decorated_data_definition.read

      expect(transformed_result).to contain_exactly(include(tag: "costello", code: "Costello"))
      expect(transformed_result).to contain_exactly(include("tag" => "costello", "code" => "Costello"))
    end

    it "fails unless the top-level is an array" do
      result = :single_value

      decorated_data_definition = data_definition.new(result).with_indifferent_access

      expect { decorated_data_definition.read }.to raise_error(
        Tdc::FatalError, "Use 'with_indifferent_access' only for an Array")
    end
  end
end
