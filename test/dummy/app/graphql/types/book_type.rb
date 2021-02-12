# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    from_active_record Book
  end
end
