# Require the RSpec configuration
require "spec_helper"

# Require the Tdc gem
require "tdc"

# Require the shared test fixture
require "support/tdc_fixture"

# Opt-in helpers
require "support/tdc_helper"

RSpec.configure do |config|
  config.include Support::TdcHelper, tdc: true
end
