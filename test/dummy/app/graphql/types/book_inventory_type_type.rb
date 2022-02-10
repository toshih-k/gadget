# frozen_string_literal: true

module Types
  class BookInventoryTypeType < Types::BaseEnum
    include Gadget::Types::Enum
    from_active_record_enum ::Book, 'inventory_type'
  end
end
