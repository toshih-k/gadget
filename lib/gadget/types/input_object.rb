# frozen_string_literal: true

module Gadget
  module Types
    #
    # base input type object for gadet
    #
    module InputObject
      extend ActiveSupport::Concern
      included do
        class << self
          def from_active_record(active_record_class, options = {})
            description "#{active_record_class.model_name.human}用のInputTypeObject"
            Gadget::Common::Utility.generate_input_arguments(self, active_record_class, options) do
              argument :_destroy, GraphQL::Types::Boolean, required: false
            end
          end
        end
      end
    end
  end
end
