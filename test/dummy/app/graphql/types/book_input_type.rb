module Types
  class BookInputType < Types::BaseInputObject
    include Gadget::Types::InputObject
    from_active_record ::Book
  end
end
