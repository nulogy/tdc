require "ostruct"

require "active_support/concern"
require "active_support/core_ext/hash/indifferent_access"

require "tdc/in_memory_data_definition"
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

require "tdc/decorator_error"
require "tdc/missing_hook_override_error"
require "tdc/missing_path_elements_error"
require "tdc/missing_test_data_definition_error"
require "tdc/non_singular_instance_error"
require "tdc/unresolvable_tag_error"
require "tdc/yaml_load_error"

#
# A framework for building a Test Data Catalog
#
module Tdc
end
