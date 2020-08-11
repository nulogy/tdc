require "ostruct"
require "yaml"

require "active_support"
require "active_support/concern"
require "active_support/core_ext"

require "tdc/version"

# Definition Resolvers
require "tdc/definition_resolvers"
require "tdc/definition_resolvers/definition_resolver"
require "tdc/definition_resolvers/tag_resolver"

# Tdc Errors
require "tdc/fatal_error"
require "tdc/missing_override_error"

# Extended Attributes
require "tdc/extended_attributes"
require "tdc/extended_attributes/interpreter_base"
require "tdc/extended_attributes/default_interpreter"
require "tdc/extended_attributes/interpreter_registry"

# Data Definition Hierarchy
require "tdc/data_definition"
require "tdc/data_definition_file_reader"
require "tdc/in_memory_data_definition"
require "tdc/with_indifferent_access_decorator"

# Generators
require "tdc/generators"
require "tdc/generators/catalog_entries"
require "tdc/generators/generation_context"

# Generator Concerns
require "tdc/generators/definition_resolvable"
require "tdc/generators/definition_sourcable"

# Generator Hierarchy
require "tdc/generators/generator_base"
require "tdc/generators/configurable_generator"
require "tdc/generators/standard_generator"

#
# A framework for building a Test Data Catalog
#
module Tdc
end
