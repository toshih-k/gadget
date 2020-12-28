module Gadget
  module Types
    module InputObject
      extend ActiveSupport::Concern
      included do
        class << self
          def from_active_record(active_record_class, options = {})
            description "input object for #{active_record_class.name}"
            Gadget::Common::Utility.generate_input_arguments(self, active_record_class, options) do
              argument :_destroy, GraphQL::Types::Boolean, required: false
            end
          end
        end
      end
    end
  end
end
