module Tdc
  module Generators
    #
    # Knows how to resolve attribute values in an instance definition. The attribute value will be replaced
    # by the result of invoking the registered resolver.
    #
    # The resolve_tag class macro is provided for generators to define tag resolution. The test data definition
    # YAML file has attribute values than contain a catalog entry tag.
    #
    # Example:
    #
    # Suppose a particular instance definition contained { subcomponent: sc_snackers_minis } then a generator
    # could resolve the subcomponent tag to the current catalog by defining:
    #
    #   resolve_tag key: :subcomponent, source: "item_master.items"
    #
    # The register_definition_resolver class macro is provided for generators to define and register their own
    # definition resolvers. The test data  definition YAML file has attribute values than contain an arbitrary
    # value that will typically be replaced by an instance of an object returned by the specified resolver.
    #
    module DefinitionResolvable
      extend ActiveSupport::Concern

      included do
        class_attribute :_definition_resolvers, instance_writer: false

        self._definition_resolvers = []
      end

      class_methods do
        def register_definition_resolver(resolver_instance)
          _definition_resolvers << resolver_instance
        end

        def resolve_tag(key:, source:)
          register_definition_resolver(Tdc::DefinitionResolvers::TagResolver.new(key: key, source: source))
        end
      end

      def run_definition_resolvers(instance_definition)
        _definition_resolvers.each do |definition_resolver|
          definition_resolver.configure_current_catalog(current_catalog)

          definition_resolver.resolve(instance_definition)
        end
      end
    end
  end
end
