module Types
  class OwnerType < Types::BaseObject
    include Gadget::Types::Object
    from_active_record ::Owner
  end
end
