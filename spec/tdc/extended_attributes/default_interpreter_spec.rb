RSpec.describe Tdc::ExtendedAttributes::DefaultInterpreter do
  subject(:default_interpreter) { described_class.new }

  before do
    Time.zone = "Eastern Time (US & Canada)"
  end

  it "default interpretation of extended attributes" do
    instance_definition = {
      "expires_on_xa" => "yesterday + 2.days",
      "planned_start_date_xa" => "today + 1.day",
      "started_at_xa" => "today + 3.hours"
    }

    default_interpreter.interpret(instance_definition)

    expect(instance_definition).to include(
      "expires_on" => Time.zone.yesterday + 2.days,
      "planned_start_date" => Time.zone.today + 1.day,
      "started_at" => Time.zone.today + 3.hours
    )
  end
end
