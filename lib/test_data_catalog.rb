require "ostruct"

require "active_support/concern"
require "active_support/core_ext/hash/indifferent_access"

require "test_data_catalog/in_memory_data_definition"
require "test_data_catalog/missing_test_data_definition"
require "test_data_catalog/test_data_definition_reader"
require "test_data_catalog/version"
require "test_data_catalog/with_indifferent_access_decorator"

require "test_data_catalog/generators"
require "test_data_catalog/generators/catalog_entries"
require "test_data_catalog/generators/definition_resolvable"
require "test_data_catalog/generators/definition_sourcable"
require "test_data_catalog/generators/generator_base"
require "test_data_catalog/generators/instance_definition_configurable"
require "test_data_catalog/generators/singular_generator"
require "test_data_catalog/generators/standard_generator"

#
# A framework for building a Test Data Catalog
#
module TestDataCatalog
end
