require "ostruct"
require "yaml"

require "active_support"
require "active_support/concern"
require "active_support/core_ext"

require "tdc/data_definition"
require "tdc/data_definition_file_reader"
require "tdc/fatal_error"
require "tdc/in_memory_data_definition"
require "tdc/missing_override_error"
require "tdc/version"
require "tdc/with_indifferent_access_decorator"

require "tdc/generators"
require "tdc/generators/catalog_entries"
require "tdc/generators/definition_resolvable"
require "tdc/generators/definition_sourcable"
require "tdc/generators/generator_base"
require "tdc/generators/instance_definition_configurable"
require "tdc/generators/singular_generator"
require "tdc/generators/standard_generator"

#
# A framework for building a Test Data Catalog
#
module Tdc
end
