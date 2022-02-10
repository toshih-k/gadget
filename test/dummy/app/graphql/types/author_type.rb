# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    include Gadget::Types::Object
    from_active_record ::Author
  end
end
