module Tdc
  module Generators
    #
    # Knows how to contain arbitrary collections of model objects. As model instances are created
    # by generators, the model instances are added to the current catalog as catalog entries.
    #
    class CatalogEntries < OpenStruct
      def add_catalog_entry(tag, entry)
        send("#{tag}=", entry)
      end

      def empty?
        to_h.empty?
      end
    end
  end
end
