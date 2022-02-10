# frozen_string_literal: true

module Types
  class AuthorInputType < Types::BaseInputObject
    include Gadget::Types::InputObject
    from_active_record Author
  end
end
