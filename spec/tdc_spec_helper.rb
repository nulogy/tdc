# Require the RSpec configuration
require "spec_helper"

# Require the Tdc gem
require "tdc"

# Require the shared test fixture
require "support/tdc_fixture"

# Require shared examples
Dir["./spec/shared_examples/generators/**/*_shared_example.rb"].sort.each { |f| require f }

# Opt-in helpers
require "support/tdc_helper"

RSpec.configure do |config|
  config.include Support::TdcHelper, tdc: true
end
