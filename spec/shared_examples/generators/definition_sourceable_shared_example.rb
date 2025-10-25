# frozen_string_literal: true

#
# Specifies behaviour for the DefinitionSourcable concern. Depends on generator to be defined.
#
RSpec.shared_examples "includes DefinitionSourcable" do
  it "invoke _definition methods" do
    instance_definitions = [
      instance_definition(tag: "manning", name: "Manning", wait: 2.0)
    ]

    generator.inject_instance_definitions(instance_definitions)

    # Inject a spy so that we can sense when the #generate_instance method is called.
    generator.define_singleton_method :generate_instance do
      add_result([name_definition, wait_definition])
    end

    generator.generate

    expect(generator.results).to eq([["Manning", 2.0]])
  end

  it "nil for a missing optional definition" do
    instance_definitions = [
      instance_definition(tag: "manning", name: "Manning", wait: 2.0)
    ]

    generator.inject_instance_definitions(instance_definitions)

    # Inject a spy so that we can sense when the #generate_instance method is called.
    generator.define_singleton_method :generate_instance do
      add_result([name_definition, wait_definition, missing_definition_optional])
    end

    generator.generate

    expect(generator.results).to eq([["Manning", 2.0, nil]])
  end

  it "raises for a missing definition" do
    instance_definitions = [
      instance_definition(tag: "manning", name: "Manning", wait: 2.0)
    ]

    generator.inject_instance_definitions(instance_definitions)

    # Inject a spy so that we can sense when the #generate_instance method is called.
    generator.define_singleton_method :generate_instance do
      add_result([name_definition, wait_definition, missing_definition])
    end

    expect { generator.generate }.to raise_error(KeyError)
  end

  it "tags are removed" do
    instance_definitions = [
      instance_definition(tag: "manning", name: "Manning", wait: 2.0)
    ]

    generator.inject_instance_definitions(instance_definitions)

    # Inject a spy so that we can sense when the #generate_instance method is called.
    generator.define_singleton_method :generate_instance do
      add_result([tag_definition])
    end

    expect { generator.generate }.to raise_error(KeyError)
  end
end
