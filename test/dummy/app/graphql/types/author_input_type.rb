# frozen_string_literal: true

module Types
  class AuthorInputType < Types::BaseInputObject
    from_active_record Author
  end
end
