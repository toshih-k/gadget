# frozen_string_literal: true

module Gadget
  module Types
    #
    # base enum type object for gadet
    #
    module Enum
      extend ActiveSupport::Concern
      included do
        class << self
          def from_active_record_enum(active_record_class, enum_name)
            description "#{active_record_class.name}.#{enum_name}"
            active_record_class.send("#{enum_name.pluralize}_i18n").each do |item_name, description|
              value item_name, description
            end
          end
        end
      end
    end
  end
end
