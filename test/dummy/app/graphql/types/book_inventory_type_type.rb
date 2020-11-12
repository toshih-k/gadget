module Types
  class BookInventoryTypeType < Types::BaseEnum
    from_active_record_enum Book, 'inventory_type'
  end
end
