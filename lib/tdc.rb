# frozen_string_literal: true

require "ostruct"
require "yaml"

require "active_support"
require "active_support/concern"
require "active_support/core_ext"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

#
# A framework for building a Test Data Catalog
#
module Tdc
end

loader.eager_load
