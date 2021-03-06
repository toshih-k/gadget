module Types
  class BookInputType < Types::BaseInputObject
    from_active_record Book
  end
end
