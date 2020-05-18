require "ostruct"

require "active_support/concern"
require "active_support/core_ext/hash/indifferent_access"

require "tdc/in_memory_data_definition"
require "tdc/missing_test_data_definition"
require "tdc/test_data_definition_reader"
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
