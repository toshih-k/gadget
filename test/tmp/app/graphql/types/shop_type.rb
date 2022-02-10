module Types
  class ShopType < Types::BaseObject
    include Gadget::Types::Object

    from_active_record Shop
  end
end
