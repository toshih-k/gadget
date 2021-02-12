# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    from_active_record Author
  end
end
