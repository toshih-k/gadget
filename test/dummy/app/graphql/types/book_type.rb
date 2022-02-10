module Types
  class BookType < Types::BaseObject
    include Gadget::Types::Object
    from_active_record ::Book
  end
end
