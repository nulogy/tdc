module Support
  module TdcHelper
    def instance_definition(definition)
      ActiveSupport::HashWithIndifferentAccess.new(definition)
    end
  end
end
