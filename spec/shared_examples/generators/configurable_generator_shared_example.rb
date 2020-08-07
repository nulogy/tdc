#
# Specifies behaviour inherited from the ConfigurableGenerator class. Depends on generator to be defined.
#
RSpec.shared_examples "inherits from ConfigurableGenerator" do
  it "inherits from ConfigurableGenerator" do
    expect(generator).to be_a_kind_of(Tdc::Generators::ConfigurableGenerator)
  end
end
