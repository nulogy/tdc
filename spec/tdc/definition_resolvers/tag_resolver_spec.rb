# frozen_string_literal: true

RSpec.describe Tdc::DefinitionResolvers::TagResolver do
  let(:current_catalog) { Tdc::Generators::CatalogEntries.new }

  it "resolves a key in the instance definition" do
    users = Tdc::Generators::CatalogEntries.new
    users.add_catalog_entry(:laurie_lancaster, :resolvable_user_laurie_lancaster)

    current_catalog.add_catalog_entry(:users, users)

    resolver = create_resolver(key: :user, source: "users")

    instance_definition = { user: :laurie_lancaster }

    resolver.resolve(instance_definition)

    expect(instance_definition).to include(user: :resolvable_user_laurie_lancaster)
  end

  it "does nothing when the key is not present in the instance definition" do
    resolver = create_resolver(key: :user, source: "users")

    instance_definition = { floor_location: :shipping }

    expect { resolver.resolve(instance_definition) }.to_not raise_error
  end

  describe "raises an error" do
    it "when a tag cannot be resolved in the instance definition" do
      users = Tdc::Generators::CatalogEntries.new
      users.add_catalog_entry(:laurie_lancaster, :resolvable_user_laurie_lancaster)

      current_catalog.add_catalog_entry(:users, users)

      resolver = create_resolver(key: :user, source: "users")

      instance_definition = { user: nil }

      expect { resolver.resolve(instance_definition) }.to raise_error(Tdc::FatalError, <<~EXPECTED_MESSAGE)
        Could not resolve key 'user' from source 'users'.

        Attempted to resolve tag '' from these tags: 'laurie_lancaster'
      EXPECTED_MESSAGE
    end

    it "when a key cannot be resolved in the instance definition" do
      users = Tdc::Generators::CatalogEntries.new
      users.add_catalog_entry(:laurie_lancaster, :resolvable_user_laurie_lancaster)
      users.add_catalog_entry(:nellie_adams, :resolvable_user_nellie_adams)

      current_catalog.add_catalog_entry(:users, users)

      resolver = create_resolver(key: :user, source: "users")

      instance_definition = { user: :unknown_user }

      expect { resolver.resolve(instance_definition) }.to raise_error(Tdc::FatalError, <<~EXPECTED_MESSAGE)
        Could not resolve key 'user' from source 'users'.

        Attempted to resolve tag 'unknown_user' from these tags: 'laurie_lancaster' and 'nellie_adams'
      EXPECTED_MESSAGE
    end
  end

  def create_resolver(key:, source:)
    resolver = described_class.new(key: key, source: source)

    allow(resolver).to receive(:current_catalog).and_return(current_catalog)

    resolver
  end
end
