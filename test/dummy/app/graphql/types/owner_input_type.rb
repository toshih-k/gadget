module Types
  class OwnerInputType < Types::BaseInputObject
    include Gadget::Types::InputObject
    from_active_record ::Owner
  end
end
