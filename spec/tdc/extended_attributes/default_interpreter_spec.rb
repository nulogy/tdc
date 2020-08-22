RSpec.describe Tdc::ExtendedAttributes::DefaultInterpreter do
  let(:custom_interpreter) {
    Class.new(described_class) do
      def convert_to_standard_attribute(extended_attribute_key)
        extended_attribute_key.gsub(/_on[yz]$/, "_on")
      end

      def extended_attribute?(extended_attribute_key)
        /_on[yz]$/ =~ extended_attribute_key
      end
    end.new
  }

  subject(:default_interpreter) { described_class.new }

  before do
    Time.zone = "Eastern Time (US & Canada)"
  end

  it "default interpretation of extended attributes" do
    instance_definition = {
      "expires_onx" => "yesterday + 2.days",
      "planned_start_datex" => "today + 1.day",
      "started_atx" => "today + 3.hours"
    }

    default_interpreter.interpret(instance_definition)

    expect(instance_definition).to include(
      "expires_on" => Time.zone.yesterday + 2.days,
      "planned_start_date" => Time.zone.today + 1.day,
      "started_at" => Time.zone.today + 3.hours
    )
  end

  it "custom interpretation of extended attributes" do
    instance_definition = {
      "expires_ony" => "yesterday + 2.days",
      "removed_onz" => "yesterday + 3.days"
    }

    custom_interpreter.interpret(instance_definition)

    expect(instance_definition).to include(
      "expires_on" => Time.zone.yesterday + 2.days,
      "removed_on" => Time.zone.yesterday + 3.days
    )
  end
end
